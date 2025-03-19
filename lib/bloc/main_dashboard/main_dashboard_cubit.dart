import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../resource/constants/app_constants.dart';

part 'main_dashboard_state.dart';

class MainDashboardCubit extends Cubit<MainDashboardState> {
  MainDashboardCubit() : super(const MainDashboardState());

  void onChangeSelectedIndex(BuildContext context, int? index) {
    if (index == AppConstants.checkInsIndex) {

    } else if (index == AppConstants.eServicesIndex) {

    } else if (index == AppConstants.workOrderRfpIndex) {
    }
    else if (index == AppConstants.messagesIndex) {
    } else if (index == AppConstants.checkOutsIndex) {
    } else if (index == AppConstants.directoryIndex) {
    }
    emit(state.copyWith(selectedIndex: index));
  }
}
