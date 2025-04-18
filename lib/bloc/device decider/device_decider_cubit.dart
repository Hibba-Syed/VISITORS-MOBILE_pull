
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visitors/resource/constants/app_constants.dart';


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



