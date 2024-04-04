import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';

const Map<Filter, bool> kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TabsScreen();
  }
}

class _TabsScreen extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];
  Map<Filter, bool> _selectedFilters = {
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegetarian: false,
    Filter.vegan: false,
  };
  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(duration: Durations.medium3, content: Text(message)));
  }

  void _toggleMealFavoriteStatus(Meal meal) {
    if (_favoriteMeals.contains(meal)) {
      setState(() {
        _favoriteMeals.remove(meal);
      });
      _showInfoMessage('${meal.title} removed from favorites!');
    } else {
      setState(() {
        _favoriteMeals.add(meal);
      });
      _showInfoMessage('${meal.title} added to favorites!');
    }
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filter') {
      final result =
          await Navigator.of(context).push<Map<Filter, bool>>(MaterialPageRoute(
        builder: (context) {
          return FiltersScreen(currentFilters: _selectedFilters);
        },
      ));
      setState(() {
        _selectedFilters = result ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final filterMeals = dummyMeals.where((meal) {
      if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      } else if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      } else if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      } else if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();

    var title = _selectedPageIndex == 0 ? 'Categories' : 'Your Favorites';
    Widget activePage = _selectedPageIndex == 0
        ? CategoriesScreen(
            onToggleFavorite: _toggleMealFavoriteStatus,
            availableMeals: filterMeals,
          )
        : MealsScreen(
            meals: _favoriteMeals, onToggleFavorite: _toggleMealFavoriteStatus);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: (index) {
          setState(() {
            _selectedPageIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites')
        ],
      ),
    );
  }
}
