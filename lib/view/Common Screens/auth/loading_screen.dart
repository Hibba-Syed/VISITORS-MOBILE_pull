import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import '../../../bloc/check_ins/check_ins_cubit.dart';
import '../../../bloc/dashboard/dashboard_cubit.dart';
import '../../../utils/routes/app_routes.dart';
import '../../widgets/loader/loader_widget.dart';
class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    getData();
    super.initState();
  }
  Future getData() async{
     await  context.read<DashboardCubit>().getProfile(context);
     await context.read<CheckInsCubit>().getCheckIns();
     await context.read<DashboardCubit>().getCheckIns();
     await context.read<DashboardCubit>().getDashboardCount();

    // if (!mounted) return;
      Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoutes.deviceDeciderScreen, (route) => false);

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
                child: LoaderWidget()),
            Gap(60),
            Text('Setting up the Dashboard',style: TextStyle(
              fontSize: 15,
              color: AppColors.darkGrey,

            ),)
          ],
        ),
      ),
    );
  }
}
