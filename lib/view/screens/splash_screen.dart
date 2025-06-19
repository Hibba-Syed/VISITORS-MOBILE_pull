import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:visitors/bloc/auth/auth_cubit.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/styles/styles.dart';
import 'package:visitors/service/LocalAuth/local_auth_service.dart';
import 'package:visitors/utils/app_utils.dart';
import 'package:visitors/utils/preference_utils.dart';
import '../../resource/constants/images.dart';
import '../../resource/globals.dart';
import '../../service/connectivity_service.dart';
import '../../utils/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      5.seconds,
      () async {
        if (!mounted) return;
        if (Globals().token?.isNotEmpty ?? false) {
          // print('token^^^${Globals().token}');
          bool result = await LocalAuthService().hasBiometricSupport();
          if (!mounted) return;
          if (result) {
            Navigator.pushNamedAndRemoveUntil(
                context, AppRoutes.biometricAuth, (route) => false);
          } else {
            _navigateToNextScreen();
          }
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoutes.login, (route) => false);
        }
      },
    );
  }

  void _navigateToNextScreen() {
    context.read<AuthCubit>().login(
          context,
          password: spUtil.password,
          communityId: spUtil.communityId,
          gate: spUtil.gate,
          loginId: spUtil.loginId,
        );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.primary,
              ),
            ),
            Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text('Nice to see you',
                            style: AppUtils.isTablet(context)
                                ? AppTextStyles.style25white600
                                : AppTextStyles.style20white600),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Visitor Management System',
                          style: AppUtils.isTablet(context)
                              ? AppTextStyles.style35white600
                              : AppTextStyles.style24white600,
                        ),
                      ),
                      Gap(40),
                      Image.asset(
                        AppImages.splash,
                        width: MediaQuery.of(context).size.height * 0.25,
                      ),
                    ],
                  ),
                ),
                Text(
                  '© ${DateTime.now().year} ISKAAN Visitor Portal',
                  style: AppTextStyles.style15white600,
                ),
                const Gap(10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
