import 'package:flutter/material.dart';

/// Created by Pratama Ramadhan on 19/09/26.

class CustomSearchBar extends StatelessWidget {
  final Function(String) onChanged;
  final TextEditingController controller;
  final String hintText;
  const CustomSearchBar({super.key, required this.onChanged, required this.controller, required this.hintText});

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
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              onTapOutside: (PointerDownEvent event) => FocusScope.of(context).requestFocus(FocusNode()),
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                isDense: true,
              ),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
