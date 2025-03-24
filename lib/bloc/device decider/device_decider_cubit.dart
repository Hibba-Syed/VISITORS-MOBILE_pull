import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart' show BuildContext;
import 'package:meta/meta.dart';
import 'package:visitors/resource/constants/app_constants.dart';

part 'device_decider_state.dart';

class DeviceDeciderCubit extends Cubit<DeviceDeciderState> {
  DeviceDeciderCubit() : super(const DeviceDeciderState());

  void onChangeSelectedIndex(BuildContext context, int? index) {
    if (index == AppConstants.dashboardIndex) {

    } else if (index == AppConstants.checkInsIndex) {

    } else if (index == AppConstants.eServicesIndex) {
    }
    else if (index == AppConstants.workOrderRfpIndex) {
    } else if (index == AppConstants.messagesIndex) {
    }
    else if (index == AppConstants.checkOutsIndex) {
    }
    else if (index == AppConstants.directoryIndex) {
    }
    emit(state.copyWith(selectedIndex: index));
  }
}