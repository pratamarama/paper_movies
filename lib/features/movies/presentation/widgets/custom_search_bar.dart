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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Row(
        children: <Widget>[
          const Icon(Icons.search, color: Colors.grey),
          const SizedBox(width: kPaddingSm),
          Expanded(
            child: TextField(
              controller: controller,
              onTapOutside: (PointerDownEvent event) => FocusScope.of(context).requestFocus(FocusNode()),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.grey[500]),
                border: InputBorder.none,
                isDense: true,
              ),
              onChanged: onChanged,
            ),
          ),
          const SizedBox(width: kPaddingSm),
          GestureDetector(
            onTap: onClear,
            child: const Icon(Icons.clear, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
