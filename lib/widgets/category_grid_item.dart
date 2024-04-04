import 'package:flutter/material.dart';
import 'package:meals/models/category.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem(
      {super.key, required this.category, required this.onSelectcategory});

  final Category category;
  final void Function() onSelectcategory;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelectcategory,
      splashColor: Theme.of(context).secondaryHeaderColor,
      borderRadius: BorderRadius.circular(10),
      child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(colors: [
                category.color.withOpacity(0.55),
                category.color.withOpacity(1)
              ], begin: Alignment.bottomRight, end: Alignment.topLeft)),
          child: Text(
            category.title,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          )),
    );
  }
}
