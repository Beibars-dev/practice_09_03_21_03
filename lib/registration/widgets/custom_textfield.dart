import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:government_mp/core/constants/app_colors.dart';
import 'package:government_mp/core/theme/text_styles.dart';

class CustomTextFieldsRegistration extends StatelessWidget {
  const CustomTextFieldsRegistration(
      {super.key, required this.controller, required this.hintText});
  final String? hintText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.darkGreen,
            hintText: hintText,
            hintStyle: TextStyle(color: AppColors.white),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
          style: TextStyles.montserattText16,
        ),
      ],
    );
  }
}
