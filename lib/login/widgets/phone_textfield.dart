import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:government_mp/core/constants/app_colors.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../../../core/theme/text_styles.dart';

class PhoneTextFields extends StatefulWidget {
  @override
  _PhoneTextFieldsState createState() => _PhoneTextFieldsState();
}

class _PhoneTextFieldsState extends State<PhoneTextFields> {
  final TextEditingController _phoneController =
      TextEditingController(text: "+7 ");

  final maskFormatter = MaskTextInputFormatter(
    mask: '+7 (###) ###-##-##',
    filter: {"#": RegExp(r'[0-9]')},
    initialText: '+7',
  );

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(() {
      if (_phoneController.text.length < 3) {
        _phoneController.text = "+7 ";
        _phoneController.selection = TextSelection.fromPosition(
          TextPosition(offset: _phoneController.text.length),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          inputFormatters: [
            maskFormatter,
          ],
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.darkGreen,
            hintText: '+7 (___) ___-__-__',
            hintStyle: TextStyles.montserattText16,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
          style: TextStyle(color: AppColors.white),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
