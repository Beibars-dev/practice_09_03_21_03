import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:government_mp/core/constants/app_colors.dart';
import 'package:government_mp/core/theme/text_styles.dart';
import 'package:government_mp/features/login/presentation/page/login_page.dart';
import 'package:government_mp/features/registration/presentation/page/registration_page.dart';

import '../../../login/presentation/widgets/custom_button.dart';

class LoginOrRegister extends StatelessWidget {
  const LoginOrRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColors.primary(context),
          body: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.only(top: 16, right: 16),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        "Рус",
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: AppColors.white,
                          fontSize: 20,
                          fontVariations: [
                            FontVariation('ital', 0),
                            FontVariation('wght', 600),
                          ],
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.white,
                        ),
                      ),
                    )),
                Spacer(),
                Center(
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        'assets/images/Logo.svg',
                        width: 170,
                        height: 170,
                      ),
                      SizedBox(height: 20),
                      Text('Мобильный', style: TextStyles.montserattText28),
                      Text('Прокурор', style: TextStyles.montserattText28),
                    ],
                  ),
                ),
                Spacer(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Column(
                    children: [
                      CustomButton(
                        text: 'Войти',
                        backgroundColor: AppColors.white,
                        textColor: AppColors.primary(context),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                      ),
                      SizedBox(height: 10),
                      CustomButton(
                        text: 'Зарегистрироваться',
                        backgroundColor: Colors.transparent,
                        textColor: AppColors.white,
                        borderColor: AppColors.white,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegistrationPage()));
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
