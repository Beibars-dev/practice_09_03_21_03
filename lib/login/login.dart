import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:government_mp/core/constants/app_colors.dart';
import 'package:government_mp/core/widgets/custom_app_bar.dart';
import 'package:government_mp/features/login/presentation/widgets/custom_button.dart';
import 'package:government_mp/features/login/presentation/widgets/password_textField.dart';
import 'package:government_mp/features/login/presentation/widgets/phone_textField.dart';

import '../../../../core/theme/text_styles.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "",
        backgroundColor: AppColors.primary(context),
        iconColor: AppColors.white,
      ),
      backgroundColor: AppColors.primary(context),
      body: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              "assets/images/Logo_background.svg",
              height: 162.h,
              width: 70.w,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 100.h),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Вход",
                      style: TextStyles.montserattText28
                          .copyWith(fontSize: 28.sp)),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: PhoneTextFields(),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: PasswordTextfield(hintText: "Пароль"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: 20.h, right: 20.w, top: 5.h),
                        child: Text(
                          "Забыли пароль?",
                          style: TextStyle(
                              fontSize: 16.sp, color: AppColors.white),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: CustomButton(
                      text: "Продолжить",
                      backgroundColor: AppColors.white,
                      textColor: AppColors.primary(context),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(height: 40.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Еще нет аккаунта?",
                        style: TextStyles.montserattText16
                            .copyWith(fontSize: 16.sp),
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        "Регистрация",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontVariations: [
                            FontVariation('ital', 0),
                            FontVariation('wght', 400),
                          ],
                          fontFamily: 'Montserrat',
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
          ),
        ],
      ),
    );
  }
}
