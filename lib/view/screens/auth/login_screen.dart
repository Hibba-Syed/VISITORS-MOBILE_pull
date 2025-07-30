import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/constants/images.dart';
import 'package:visitors/utils/routes/app_routes.dart';
import 'package:visitors/view/widgets/Alert_dialog_box/custom_alert_dialog_box.dart';
import 'package:visitors/view/widgets/loader/loader_widget.dart';
import '../../../bloc/auth/auth_cubit.dart';
import '../../../resource/styles/styles.dart';
import '../../../service/LocalAuth/local_auth_service.dart';
import '../../../utils/app_utils.dart';
import '../../../utils/preference_utils.dart';
import '../../widgets/button/custom_button.dart';
import '../../widgets/text field/password_text_field.dart';
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
  final TextEditingController _gateController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  bool _hasBiometricSupport = false;

  @override
  void initState() {
    super.initState();
    _checkBiometricSupport();
  }

  Future<void> _checkBiometricSupport() async {
    _hasBiometricSupport = await LocalAuthService().hasBiometricSupport();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

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
    _gateController.dispose();
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
              ),
              fit: BoxFit.fill)),
      alignment: Alignment.center,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: Image.asset(
                  AppImages.appLogo,
                  width: MediaQuery.of(context).size.width * 0.15,
                ),
              ),
              Gap(10),
              Text(
                AppUtils.languageTranslate('visitorManagementSystem'),
                style: AppUtils.isTablet(context)
                    ? AppTextStyles.style25black600
                    : AppTextStyles.style20black600,
              ),
              Gap(20.0),
              TextFieldWidget(
                controller: _communityIdController,
                hint: AppUtils.languageTranslate('enterCommunityID'),
                validator: (value) {
                  if (value?.trim().isEmpty ?? true) {
                    return AppUtils.languageTranslate('fieldIsMandatory');
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
                controller: _gateController,
                hint: AppUtils.languageTranslate('enterGateNameNumber'),
                validator: (value) {
                  if (value?.trim().isEmpty ?? true) {
                    return AppUtils.languageTranslate('fieldIsMandatory');
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
                hint: AppUtils.languageTranslate('enterLoginID'),
                validator: (value) {
                  if (value?.trim().isEmpty ?? true) {
                    return AppUtils.languageTranslate('fieldIsMandatory');
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
                hint: AppUtils.languageTranslate('enterYourPassword'),
                validator: (value) {
                  if (value?.trim().isEmpty ?? true) {
                    return AppUtils.languageTranslate('fieldIsMandatory');
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
                              title:
                                  AppUtils.languageTranslate('forgotPassword'),
                              insetPadding: AppUtils.isTablet(context)
                                  ? EdgeInsets.symmetric(horizontal: 35)
                                  : EdgeInsets.symmetric(horizontal: 10),
                              contentBuilder: (context, setState) {
                                return Align(
                                  alignment: Alignment.center,
                                  child: Column(
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
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Text(
                                          AppUtils.languageTranslate(
                                              'pleaseContactAdminToGetISKAANVisitorManagementSystemCredentials'),
                                          textAlign: TextAlign.center,
                                          style: AppUtils.isTablet(context)
                                              ? AppTextStyles.style18black600
                                              : AppTextStyles.style15Black600,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        });
                  },
                  child: Text(
                    AppUtils.languageTranslate('forgotPassword'),
                    style: AppUtils.isMobile(context)
                        ? AppTextStyles.style14Primary600
                        : AppTextStyles.style16Primary600,
                  ),
                ),
              ),
              Gap(15),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    LoaderWidget();
                  }
                  return CustomButton(
                    height: AppUtils.isTablet(context) ? 60 : 42,
                    fontSize: AppUtils.isTablet(context) ? 20 : 15,
                    text: AppUtils.languageTranslate('signIn'),
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        context.read<AuthCubit>().login(
                              context,
                              communityId: _communityIdController.text,
                              gate: _gateController.text,
                              loginId: _loginIdController.text,
                              password: _passwordController.text,
                            );
                      }
                    },
                  );
                },
              ),
              if ((spUtil.communityId?.isNotEmpty ?? false) &&
                  (spUtil.gate?.isNotEmpty ?? false) &&
                  (spUtil.loginId?.isNotEmpty ?? false) &&
                  (spUtil.password?.isNotEmpty ?? false) &&
                  _hasBiometricSupport) ...[
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
                      AppUtils.languageTranslate('or'),
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
                  height: AppUtils.isTablet(context) ? 60 : 42,
                  fontSize: AppUtils.isTablet(context) ? 20 : 15,
                  text: AppUtils.languageTranslate('biometricLogin'),
                  invert: true,
                  onPressed: () async {
                    Navigator.pushNamedAndRemoveUntil(
                        context, AppRoutes.biometricAuth, (route) => false);
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
