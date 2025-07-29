import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/utils/app_utils.dart';
import '../../../bloc/dashboard/dashboard_cubit.dart';
import '../../../bloc/main_dashboard/main_dashboard_cubit.dart';
import '../../widgets/loader/loader_widget.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    context.read<DashboardCubit>().getData(context);
    context.read<MainDashboardCubit>().resetDashboard();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 70,
              width: 70,
              child: LoaderWidget(),
            ),
            Gap(60),
            Text(
              AppUtils.languageTranslate('WaitWhileSettingUpTheDashboard'),
              style: TextStyle(
                fontSize: 15,
                color: AppColors.darkGrey,
              ),
            )
          ],
        ),
      ),
    );
  }
}
