import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart'
    show
        AlertDialog,
        BuildContext,
        Column,
        Flexible,
        Icon,
        Icons,
        MainAxisSize,
        MediaQuery,
        Navigator,
        Row,
        SizedBox,
        Text,
        showDialog;
import 'package:gap/gap.dart';
import 'package:meta/meta.dart';
import 'package:visitors/resource/constants/app_constants.dart';

import '../../resource/constants/app_colors.dart';
import '../../resource/styles/styles.dart';
import '../../view/widgets/button/custom_button.dart';

part 'device_decider_state.dart';

class DeviceDeciderCubit extends Cubit<DeviceDeciderState> {
  DeviceDeciderCubit() : super(const DeviceDeciderState());

  // void onChangeSelectedIndex(BuildContext context, int? index) {
  //   if (index == AppConstants.dashboardIndex) {
  //
  //   } else if (index == AppConstants.checkInsIndex) {
  //
  //   } else if (index == AppConstants.eServicesIndex) {
  //
  //   }
  //   else if (index == AppConstants.workOrderRfpIndex) {
  //
  //   } else if (index == AppConstants.messagesIndex) {
  //
  //   }
  //   else if (index == AppConstants.checkOutsIndex) {
  //   }
  //   else if (index == AppConstants.directoryIndex) {
  //   }
  //   emit(state.copyWith(selectedIndex: index));
  // }
  void onChangeSelectedIndex(BuildContext context,int index) {
    if (index == AppConstants.dashboardIndex) {
      emit(state.copyWith(
        selectedIndex: index,
        navigationHistory: [],
      ));
    } else {
      final history = List<int>.from(state.navigationHistory);
      if (state.selectedIndex != AppConstants.dashboardIndex) {
        history.add(state.selectedIndex);
      }
      // print('Selected NH: ${state.navigationHistory}');
      // print('Selected Index: ${state.selectedIndex}');
      emit(state.copyWith(
        selectedIndex: index,
        navigationHistory: history,
      ));
    }
  }

  void onBackButtonPressed() {
    print('Back pressed History: ${state.navigationHistory}');
    final history = List<int>.from(state.navigationHistory);
    if (history.isNotEmpty) {
      final previousIndex = history.removeLast();
      emit(state.copyWith(
        selectedIndex: previousIndex,
        navigationHistory: history,
      ));
    } else if (state.selectedIndex != AppConstants.dashboardIndex) {
      emit(state.copyWith(
        selectedIndex: AppConstants.dashboardIndex,
        navigationHistory: [],
      ));
    }
        }
  }



