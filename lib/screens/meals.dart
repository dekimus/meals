import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meal_screen.dart';
import 'package:meals/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    required this.meals,
    this.title,
  });

  final List<Meal> meals;
  final String? title;

  void selectMeal(BuildContext ctx, Meal meal) {
    Navigator.push(
        ctx,
        MaterialPageRoute(
          builder: (context) => MealScreen(
            meal: meal,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: meals.length,
      itemBuilder: (context, index) => MealItem(
        meal: meals[index],
        onSelectMeal: (meal) {
          selectMeal(context, meal);
        },
      ),
    );

    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Oh oh... Nothing here!",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "Try selecting a different category!",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            )
          ],
        ),
      );
    }

    if (title == null) return content;

    return Scaffold(
        appBar: AppBar(
          title: Text(title!),
        ),
        body: content);
  }
}
