import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart' show AlertDialog, BuildContext, Column, Flexible, Icon, Icons, MainAxisSize, MediaQuery, Navigator, Row, SizedBox, Text, showDialog;
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
  void onChangeSelectedIndex(BuildContext context, int? index) {
    if (index != null) {
      if (index == 1) {
        emit(state.copyWith(selectedIndex: index, navigationHistory: [index]));
      } else {
        List<int> updatedHistory = List.from(state.navigationHistory);
        updatedHistory.remove(index);
        updatedHistory.insert(0, index);

        emit(state.copyWith(selectedIndex: index, navigationHistory: updatedHistory));
      }
    }
  }
  void onBackButtonPressed() {
    if (state.navigationHistory.isNotEmpty) {
      List<int> updatedHistory = List.from(state.navigationHistory);
      updatedHistory.removeAt(0);
      int? lastIndex = updatedHistory.isNotEmpty ? updatedHistory.first : null;
      if (lastIndex != null) {
        if (lastIndex == 1) {
          emit(state.copyWith(selectedIndex: lastIndex, navigationHistory: [lastIndex]));
        } else {
          emit(state.copyWith(selectedIndex: lastIndex, navigationHistory: updatedHistory));
        }
      }
    }
  }

//
//   void onChangeSelectedIndex(BuildContext context, int? index) {
//     if (index != null) {
//       List<int> updatedHistory = List.from(state.navigationHistory);
//       updatedHistory.remove(index);
//       updatedHistory.insert(0, index);
//       emit(state.copyWith(selectedIndex: index, navigationHistory: updatedHistory));
//     }
//   }
//   void onBackButtonPressed() {
//     if (state.navigationHistory.isNotEmpty) {
//
//       List<int> updatedHistory = List.from(state.navigationHistory);
//       updatedHistory.removeAt(0);
//       int? lastIndex = updatedHistory.isNotEmpty ? updatedHistory.first : null;
//
//       emit(state.copyWith(selectedIndex: lastIndex, navigationHistory: updatedHistory));
//     }
//   }
}