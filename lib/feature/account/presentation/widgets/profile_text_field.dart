import 'package:flutter/material.dart';

class CustomProfileTextField extends StatelessWidget {
  final String title;
  final String hintText;
  final IconData icon;
  final TextEditingController? controller;
  final bool enabled;
  final TextInputType? keyboardType;

  const CustomProfileTextField({
    super.key,
    required this.title,
    required this.hintText,
    required this.icon,
    this.controller,
    this.enabled = true,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 8),


        TextField(
          controller: controller,
          enabled: enabled,
          keyboardType: keyboardType,

          decoration: InputDecoration(

            hintText: hintText,

            prefixIcon: Icon(
              icon,
              size: 22,
            ),


            filled: true,

            fillColor: Colors.white,


            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xffE0D7F5),
              ),
            ),


            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xffE0D7F5),
              ),
            ),


            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.deepPurple,
              ),
            ),
          ),
        ),


        const SizedBox(height: 16),
      ],
    );
  }
}