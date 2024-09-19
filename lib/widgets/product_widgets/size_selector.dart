import 'package:flutter/material.dart';

class SizeSelector extends StatefulWidget {
  final List<String> sizes;

  const SizeSelector({super.key, required this.sizes});

  @override
  _SizeSelectorState createState() => _SizeSelectorState();
}

class _SizeSelectorState extends State<SizeSelector> {
  String? selectedSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: widget.sizes.map((size) {
        return ChoiceChip(
          label: Text(size),
          selected: selectedSize == size,
          onSelected: (selected) {
            setState(() {
              selectedSize = size;
            });
          },
        );
      }).toList(),
    );
  }
}
