import 'package:flutter/material.dart';

Widget customTextFormField({
  required String hint,
  required IconData prefixIcon,
  IconData? suffixIcon,
  bool obscureText = false,
  VoidCallback? onSuffixTap,
  String? errorText,
  TextEditingController? controller,
  TextInputType keyboardType = TextInputType.text,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: errorText != null ? Colors.redAccent : Colors.grey.shade800,
            width: 1.2,
          ),
        ),
        child: TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          style: const TextStyle(color: Colors.white, fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade600, fontSize: 14),
            prefixIcon: Icon(prefixIcon, color: Colors.grey.shade600, size: 20),
            suffixIcon: suffixIcon != null
                ? GestureDetector(
                    onTap: onSuffixTap,
                    child: Icon(
                      suffixIcon,
                      color: Colors.grey.shade600,
                      size: 20,
                    ),
                  )
                : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
      if (errorText != null) ...[
        const SizedBox(height: 6),
        Text(
          errorText,
          style: const TextStyle(color: Colors.redAccent, fontSize: 12),
        ),
      ],
    ],
  );
}
