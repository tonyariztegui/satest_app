import 'package:flutter/material.dart';

class FilterTabs extends StatelessWidget {
  final String selectedFilter;
  final Function(String) onFilterSelected;
  final List<String> filters;

  FilterTabs({
    required this.selectedFilter,
    required this.onFilterSelected,
    required this.filters,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: filters.map((filter) {
          return GestureDetector(
            onTap: () => onFilterSelected(filter),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: selectedFilter == filter
                        ? Colors.orange
                        : Colors.transparent,
                    width: 2.0,
                  ),
                ),
              ),
              child: Text(
                filter,
                style: TextStyle(
                  fontWeight: selectedFilter == filter
                      ? FontWeight.bold
                      : FontWeight.normal,
                  color: selectedFilter == filter
                      ? Colors.orange
                      : Colors.black,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
