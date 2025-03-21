import 'package:flutter/material.dart';
import 'package:government_mp/core/theme/text_styles.dart';

import '../../../../core/constants/app_colors.dart';

class PasswordTextfield extends StatefulWidget {
  const PasswordTextfield({super.key, required this.hintText});
  final String? hintText;

  @override
  State<PasswordTextfield> createState() => _PasswordTextfieldState();
}

class _PasswordTextfieldState extends State<PasswordTextfield> {
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: _passwordController,
          obscureText: !_isPasswordVisible,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.darkGreen,
            hintText: widget.hintText,
            hintStyle: TextStyles.montserattText16,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.white70,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
          ),
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
