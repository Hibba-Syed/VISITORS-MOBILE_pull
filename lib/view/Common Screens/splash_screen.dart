import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:visitors/resource/styles/styles.dart';
import 'package:visitors/utils/app_utils.dart';
import '../../resource/constants/images.dart';
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
      4.seconds,
      () {
        if (!mounted) return;
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoutes.loginScreen, (route) => false);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppImages.splashBg),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter),
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
                      child: Text('Nice to see you again',
                        style: AppUtils.isTablet(context) ? AppTextStyles.style25black600 : AppTextStyles.style20black600 ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text('Visitor Management System',
                        style: AppUtils.isTablet(context) ? AppTextStyles.style35primary600: AppTextStyles.style24primary600,
                      ),
                    ),
                     Gap(40),
                    Image.asset(
                      AppImages.vmImage,
                      width: MediaQuery.of(context).size.height * 0.25,
                    ),
                  ],
                ),
              ),
              Text('© ${DateTime.now().year} ISKAAN Visitor Portal',style: AppTextStyles.style15DarkGrey600,),
              const Gap(10),
            ],
          ),
        ],
      ),
    );
  }

}
