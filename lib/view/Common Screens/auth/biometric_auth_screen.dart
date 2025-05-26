import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:visitors/view/widgets/app_bar/appbar_widget.dart';

import '../../../bloc/auth/auth_cubit.dart';
import '../../../resource/constants/app_colors.dart';
import '../../../resource/constants/images.dart';
import '../../../resource/styles/styles.dart';
import '../../../service/LocalAuth/local_auth_service.dart';
import '../../../utils/preference_utils.dart';
import '../../widgets/button/custom_button.dart';

class BiometricAuthScreen extends StatefulWidget {
  final Map<dynamic, dynamic>? notificationData;
  const BiometricAuthScreen({super.key, this.notificationData});

  @override
  State<BiometricAuthScreen> createState() => _BiometricAuthScreenState();
}

class _BiometricAuthScreenState extends State<BiometricAuthScreen> {
  final LocalAuthService _localAuthService = LocalAuthService();

  @override
  void initState() {
    super.initState();
    _authenticateUser();
  }

  Future<void> _authenticateUser() async {
    bool isAuthenticated = await _localAuthService.authenticate();
    print('isAuthenticated^^^$isAuthenticated');
    if (isAuthenticated) {
      _navigateToNextScreen();
    }
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
    return Scaffold(
      appBar: AppBarWidget(
        title: 'Authenticate',
        isBackButtonEnabled: false,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) {
                  return AlertDialog(
                    insetPadding: EdgeInsets.all(20),
                    content: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            AppImages.logout,
                            height: 35,
                            width: 35,
                            colorFilter: const ColorFilter.mode(
                              AppColors.primary,
                              BlendMode.srcIn,
                            ),
                          ),
                          Gap(16),
                          Text(
                            'Are you sure you want to logout?',
                            style: AppTextStyles.style16DarkGrey600,
                          ),
                          Gap(20),
                          Row(
                            children: [
                              Flexible(
                                child: CustomButton(
                                  text: 'Cancel',
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                              Gap(10.0),
                              Flexible(
                                child: CustomButton(
                                  text: 'Logout',
                                  invert: true,
                                  onPressed: () {
                                    Navigator.pop(context);
                                    context.read<AuthCubit>().logout(context);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            icon: SvgPicture.asset(
              AppImages.logout,
              width: 22,
              height: 22,
              colorFilter: ColorFilter.mode(
                AppColors.primary,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 2.0,
              ),
            ],
          ),
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.fingerprint,
                size: 50,
                color: AppColors.primary,
              ),
              SizedBox(height: 15),
              Text(
                "Authenticate to continue",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Use your fingerprint or Face ID to access the app.",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              CustomButton(
                text: "Authenticate",
                onPressed: _authenticateUser,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
