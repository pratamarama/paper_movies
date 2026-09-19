import 'package:flutter/material.dart';
import 'package:paper_movies/features/movies/domain/entities/category.dart';
import 'package:paper_movies/features/movies/presentation/extensions/build_context.dart';

/// Created by Pratama Ramadhan on 19/09/26.

class CategoryChip extends StatelessWidget {
  final bool isSelected;
  final Category category;
  final Function() onSelected;
  const CategoryChip({super.key, required this.isSelected, required this.category, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(category.name),
        selected: isSelected,
        onSelected: (_) => onSelected.call(),
        selectedColor: context.colorScheme.primary,
        showCheckmark: false,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : context.colorScheme.primary,
          fontWeight: FontWeight.w500,
        ),
        side: BorderSide(
          color: isSelected ? context.colorScheme.primary : context.colorScheme.primaryContainer,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
