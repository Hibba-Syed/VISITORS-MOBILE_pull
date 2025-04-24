import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/constants/images.dart';
import 'package:visitors/utils/routes/app_routes.dart';
import 'package:visitors/view/widgets/Alert_dialog_box/custom_alert_dialog_box.dart';
import 'package:visitors/view/widgets/text%20field/password_text_field.dart';

import '../../../resource/styles/styles.dart';
import '../../widgets/button/custom_button.dart';
import '../../widgets/text field/text_field_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _communityIdController = TextEditingController();
  final TextEditingController _loginIdController = TextEditingController();
  final TextEditingController _gateIdController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: _loginUi(context),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _communityIdController.dispose();
    _passwordController.dispose();
    _gateIdController.dispose();
    _loginIdController.dispose();
  }

  Widget _loginUi(
    BuildContext context,
  ) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage(
          AppImages.background,
        ), fit: BoxFit.fill
      )),
      alignment: Alignment.center,
      child: SingleChildScrollView(
        padding:  EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppImages.appLogo,
                width: MediaQuery.of(context).size.height * 0.15,
              ),
              Gap(5),
              Text(
                'Visitor Management System',
                style: AppTextStyles.style20black600,
              ),
              Gap(20.0),
              TextFieldWidget(
                controller: _communityIdController,
                hint: 'Enter Community ID',
                validator: (value) {
                  if (value?.trim().isEmpty ?? true) {
                    return "Field is mandatory";
                  }
                  return null;
                },
                prefix: SvgPicture.asset(
                  AppImages.loginCommunity,
                  fit: BoxFit.scaleDown,
                  colorFilter: const ColorFilter.mode(
                    AppColors.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              Gap(15),
              TextFieldWidget(
                controller: _communityIdController,
                hint: 'Enter Gate Name / Number',
                validator: (value) {
                  if (value?.trim().isEmpty ?? true) {
                    return "Field is mandatory";
                  }
                  return null;
                },
                prefix: SvgPicture.asset(
                  AppImages.loginGate,
                  fit: BoxFit.scaleDown,
                  colorFilter: const ColorFilter.mode(
                    AppColors.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              Gap(15),
              TextFieldWidget(
                controller: _loginIdController,
                hint: 'Enter Login ID',
                validator: (value) {
                  if (value?.trim().isEmpty ?? true) {
                    return "Field is mandatory";
                  }
                  return null;
                },
                prefix: SvgPicture.asset(
                  fit: BoxFit.scaleDown,
                  AppImages.loginProfile,
                  colorFilter: const ColorFilter.mode(
                    AppColors.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              Gap(15),
              PasswordTextField(
                controller: _passwordController,
                hint: 'Enter your password',
                validator: (value) {
                  if (value?.trim().isEmpty ?? true) {
                    return 'Field is mandatory';
                  }
                  return null;
                },
              ),
              Gap(15),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return CustomAlertDialogBox(
                              hideBothButtons: true,
                              title: 'Forgot Password',
                              insetPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              contentBuilder: (context, setState) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Gap(10),
                                    SvgPicture.asset(
                                      AppImages.forgot,
                                      height: 45,
                                      width: 45,
                                      colorFilter: const ColorFilter.mode(
                                        AppColors.primary,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    Gap(20),
                                    Text(
                                      'Please contact admin to get ISKAAN Visitor Management System credentials',
                                      style: AppTextStyles.style16black600,
                                    ),
                                  ],
                                );
                              });
                        });
                  },
                  child: Text(
                    "Forgot password?",
                    style: AppTextStyles.style14Primary600,
                  ),
                ),
              ),
              Gap(15),
              CustomButton(
                text: "Sign In",
                onPressed: () async {
                  Navigator.pushNamed(context, AppRoutes.deviceDeciderScreen);
                  if (_formKey.currentState?.validate() ?? false) {

                  }
                },
              ),
              Gap(10),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: AppColors.primary,
                    ),
                  ),
                  Gap(5),
                  Text(
                    'OR',
                    style: AppTextStyles.style14Primary600,
                  ),
                  Gap(5),
                  Expanded(
                    child: Divider(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              Gap(10),
              CustomButton(
                text: "Biometric Login",
                invert: true,
                onPressed: () async {
                  Navigator.pushNamedAndRemoveUntil(
                      context, AppRoutes.biometricAuth, (route) => false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
