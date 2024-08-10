import 'package:flutter/material.dart';
import 'package:tour_and_travel/core/colors.dart';

class CustomDropdown<T> extends StatelessWidget {
  final T? value;
  final List<T> items;
  final String label;
  final void Function(T? value) onChanged;
  final String Function(T value) itemLabel;

  const CustomDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.label,
    required this.onChanged,
    required this.itemLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14.0,
          ),
        ),
        const SizedBox(height: 8.0),
        DropdownButtonFormField<T>(
          value: value,
          onChanged: onChanged,
          style: const TextStyle(fontSize: 14.0, color: AppColors.black),
          items: items.map((T item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(itemLabel(item)),
            );
          }).toList(),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: BorderSide(color: AppColors.gray),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: BorderSide(color: AppColors.gray),
            ),
            hintText: value != null ? itemLabel(value as T) : "-",
          ),
        ),
      ],
    );
  }
}
