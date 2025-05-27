import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../model/service/add_service_log_response_model.dart';
import '../../../model/service/service_details_model.dart';
import '../../../model/service/service_details_response_model.dart';
import '../../../repo/services/services_repo.dart';
import '../../../repo/services/services_repo_impl.dart';

part 'service_details_state.dart';

class ServiceDetailsCubit extends Cubit<ServiceDetailsState> {
  ServiceDetailsCubit() : super(ServiceDetailsState());
  final ServiceRepo _serviceRepo = ServiceRepoImpl();

  Future<ServiceDetailsResponseModel?> getServiceDetails({required int? serviceId,String? type}) async {
    emit(state.copyWith(isLoading: true));
    ServiceDetailsResponseModel? response =
    await _serviceRepo.getServiceDetails(
      serviceId: serviceId
    ).onError(
          (error, stackTrace) {
        emit(state.copyWith(isLoading: false));
        Fluttertoast.showToast(
          msg: error.toString(),
        );
        throw error!;
      },
    );
    print("Status Code::: ${response?.code}");
    if (response != null && response.status == 'success') {
      emit(state.copyWith(
        isLoading: false,
        serviceDetails: response.record,
      ));
      return response;
    } else {
      Fluttertoast.showToast(
          msg: 'Something went wrong while fetching service details'
      );
      emit(state.copyWith(isLoading: false));
      return null;
    }
  }

  Future<bool> addServiceLog(
      BuildContext context, {
        required Map<String, dynamic> data,
      }) async {
    emit(state.copyWith(isAddLogLoading: true));
    try {
      AddServiceLogResponseModel? response = await _serviceRepo
          .addServiceLog(data: data)
          .onError((error, stackTrace) {
        emit(state.copyWith(isAddLogLoading: false));
        Fluttertoast.showToast(
          msg: error.toString(),
        );
        return null;
      });

      emit(state.copyWith(isAddLogLoading: false));

      if (response != null && response.status == 'success') {
        Fluttertoast.showToast(msg: 'Log added successfully');
        getServiceDetails(serviceId: context.read<ServiceDetailsCubit>().state.serviceDetails?.id);
        return true;
      } else {
        Fluttertoast.showToast(
            msg: 'Something went wrong while adding log');
        return false;
      }
    } catch (e) {
      emit(state.copyWith(isAddLogLoading: false));
      Fluttertoast.showToast(msg: e.toString());
      return false;
    }
  }

}
