import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/main_drawer.dart';


const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false
};

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() {
    return _TapScreenState();
  }
}

class _TapScreenState extends State<TabScreen> {
  int _selectedIndex = 0;
  final List<Meal> _favoriteMeals = [];

  Map<Filter, bool> _selectedFilters = kInitialFilters;

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _toggleMealFavoriteStatus(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);

    if (isExisting) {
      setState(() {
        _favoriteMeals.remove(meal);
      });
      _showInfoMessage("Meal is no longer Favorite.");
    } else {
      setState(() {
        _favoriteMeals.add(meal);
      });
      _showInfoMessage("Marked as Favorite!");
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(builder: (ctx) =>   FiltersScreen(
          currentFilters: _selectedFilters,
          )),
      );
      setState(() {
        _selectedFilters = result ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where((meal) {
      if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      // if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
      //   return false;
      // }
      return true;
    }).toList();

    Widget acticePage = CategoryScreen(
        onToggleFavorite: _toggleMealFavoriteStatus,
        availableMeals: availableMeals);

    String acticePageTitle = "Pick Your Category";

    if (_selectedIndex == 1) {
      acticePage = MealsScreen(
        meals: _favoriteMeals,
        onToggleFavorite: _toggleMealFavoriteStatus,
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
