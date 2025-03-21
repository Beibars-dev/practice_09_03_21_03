import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:government_mp/core/constants/app_colors.dart';
import 'package:government_mp/core/theme/text_styles.dart';
import 'package:government_mp/core/widgets/custom_app_bar.dart';
import 'package:government_mp/features/login/presentation/widgets/custom_button.dart';
import 'package:government_mp/features/login/presentation/widgets/password_textField.dart';
import 'package:government_mp/features/login/presentation/widgets/phone_textField.dart';
import '../widgets/custom_textField_registration.dart';

class RegistrationPage extends StatelessWidget {
  RegistrationPage({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surNameController = TextEditingController();
  final TextEditingController _patroNameController = TextEditingController();
  final TextEditingController _organNameController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();
  final TextEditingController _iinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "",
        backgroundColor: AppColors.primary(context),
        iconColor: AppColors.white,
      ),
      backgroundColor: AppColors.primary(context),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned.fill(
              child: SvgPicture.asset(
                "assets/images/Logo_background.svg",
                height: 162.h,
                width: 70.w,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Text("Регистрация",
                          style: TextStyles.montserattText28)),
                  SizedBox(height: 20.h),
                  PhoneTextFields(),
                  CustomTextFieldsRegistration(
                      controller: _surNameController, hintText: "Фамилия"),
                  SizedBox(height: 10.h),
                  CustomTextFieldsRegistration(
                      controller: _nameController, hintText: "Имя"),
                  SizedBox(height: 10.h),
                  CustomTextFieldsRegistration(
                      controller: _patroNameController, hintText: "Отчество"),
                  SizedBox(height: 10.h),
                  CustomTextFieldsRegistration(
                      controller: _organNameController,
                      hintText: "Наименование органа"),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFieldsRegistration(
                            controller: _jobController, hintText: "Должность"),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: CustomTextFieldsRegistration(
                            controller: _iinController, hintText: "ИИН"),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  PasswordTextfield(hintText: "Пароль"),
                  SizedBox(height: 10.h),
                  PasswordTextfield(hintText: "Повторите пароль"),
                  SizedBox(height: 20.h),
                  CustomButton(
                    text: "Продолжить",
                    backgroundColor: AppColors.white,
                    textColor: AppColors.primary(context),
                    onPressed: () {},
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Еще нет аккаунта?",
                          style: TextStyles.montserattText16),
                      SizedBox(width: 5.w),
                      Text(
                        "Регистрация",
                        style: TextStyle(
                          fontSize: 16.sp,
                          decoration: TextDecoration.underline,
                          color: Color(0xffEBBB73),
                          decorationColor: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
