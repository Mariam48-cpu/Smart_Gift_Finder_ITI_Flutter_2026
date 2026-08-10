import 'package:flutter/material.dart';

class CustomSaveButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const CustomSaveButton({
    super.key,
    required this.onPressed,
    this.text = "✓ Save Changes",
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,

      child: ElevatedButton(
        onPressed: onPressed,

        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),

          backgroundColor: Colors.deepPurple,
        ),

        child: Text(
          text,

          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
