import 'package:flutter/material.dart';
import 'package:paper_movies/constants/app_padding.dart';

/// Created by Pratama Ramadhan on 19/09/26.

class CustomSearchBar extends StatelessWidget {
  final Function(String) onChanged;
  final Function() onClear;
  final TextEditingController controller;
  final String hintText;
  const CustomSearchBar({
    super.key,
    required this.onChanged,
    required this.controller,
    required this.hintText,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onTapOutside: (PointerDownEvent event) => FocusScope.of(context).requestFocus(FocusNode()),
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: const EdgeInsets.only(bottom: kPaddingMd, top: 0),
        hintStyle: TextStyle(color: Colors.grey[500]),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        suffixIcon: GestureDetector(
          onTap: onClear,
          child: const Icon(Icons.clear, color: Colors.grey),
        ),
      ),
      onChanged: onChanged,
    );
  }
}
