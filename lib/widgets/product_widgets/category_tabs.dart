import 'package:flutter/material.dart';

class CategoryTabs extends StatelessWidget {
  final int selectedCategoryIndex;
  final Function(int) onCategorySelected;
  final List<String> categories;

  CategoryTabs({
    required this.selectedCategoryIndex,
    required this.onCategorySelected,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(categories.length, (index) {
          return GestureDetector(
            onTap: () => onCategorySelected(index),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: selectedCategoryIndex == index
                        ? Colors.orange
                        : Colors.transparent,
                    width: 2.0,
                  ),
                ),
              ),
              child: Text(
                categories[index],
                style: TextStyle(
                  fontWeight: selectedCategoryIndex == index
                      ? FontWeight.bold
                      : FontWeight.normal,
                  color: selectedCategoryIndex == index
                      ? Colors.orange
                      : Colors.black,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
