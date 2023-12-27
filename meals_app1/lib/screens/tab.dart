import 'package:flutter/material.dart';
import 'package:meals_app1/screens/categories.dart';
import 'package:meals_app1/screens/filters.dart';
import 'package:meals_app1/screens/meals.dart';
import 'package:meals_app1/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app1/providers/favorites_provider.dart';
import 'package:meals_app1/providers/filters_provider.dart';

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});

  @override
  ConsumerState<TabScreen> createState() {
    return _TapScreenState();
  }
}

class _TapScreenState extends ConsumerState<TabScreen> {
  int _selectedIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(builder: (ctx) => const FiltersScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealsProvider);

    Widget acticePage = CategoryScreen(availableMeals: availableMeals);

    String acticePageTitle = "Pick Your Category";

    if (_selectedIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      acticePage = MealsScreen(
        meals: favoriteMeals,
      );
      acticePageTitle = "Your Favorites";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(acticePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: acticePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: "Categories",
          ), //0 index
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "Favorites",
          ), //1 index
        ],
      ),
    );
  }
}
