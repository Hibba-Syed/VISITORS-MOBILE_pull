import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:visitors/repo/payment/payment_repo.dart';
import 'package:visitors/repo/payment/payment_repo_impl.dart';
import 'package:visitors/utils/app_utils.dart';
import '../../../model/service/add_service_log_response_model.dart';
import '../../../model/service/service_details_model.dart';
import '../../../model/service/service_details_response_model.dart';
import '../../../model/service/visitors_service_complete_response_model.dart';
import '../../../repo/services/services_repo.dart';
import '../../../repo/services/services_repo_impl.dart';
import '../service_cubit.dart';

part 'service_details_state.dart';

class ServiceDetailsCubit extends Cubit<ServiceDetailsState> {
  ServiceDetailsCubit() : super(ServiceDetailsState());
  final ServiceRepo _serviceRepo = ServiceRepoImpl();
  final PaymentRepo _paymentRepo = PaymentRepoImpl();

  void onChangeApplicationType(String? type) {
    emit(state.copyWith(applicationType: type));
  }

  void clearData() {
    emit(state.copyWith(serviceDetails: ServiceDetailsModel()));
  }

  Future<ServiceDetailsResponseModel?> getServiceDetails({
    required int? serviceId,
  }) async {
    emit(state.copyWith(isLoading: true));
    ServiceDetailsResponseModel? response = await _serviceRepo
        .getServiceDetails(
            serviceId: serviceId, applicationType: state.applicationType)
        .onError(
      (error, stackTrace) {
        emit(state.copyWith(isLoading: false));
        Fluttertoast.showToast(
          msg: error.toString(),
        );
        throw error!;
      },
    );
    if (response != null && response.status == 'success') {
      emit(state.copyWith(
        isLoading: false,
        serviceDetails: response.record,
      ));
      return response;
    } else {
      Fluttertoast.showToast(
          msg: AppUtils.languageTranslate(
              'somethingWentWrongWhileFetchingServiceDetails'));
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
        Fluttertoast.showToast(
            msg: AppUtils.languageTranslate('logAddedSuccessfully'));
        if (context.mounted) {
          getServiceDetails(
              serviceId:
                  context.read<ServiceDetailsCubit>().state.serviceDetails?.id);
        }
        return true;
      } else {
        Fluttertoast.showToast(
            msg:
                AppUtils.languageTranslate('somethingWentWrongWhileAddingLog'));
        return false;
      }
    } catch (e) {
      emit(state.copyWith(isAddLogLoading: false));
      Fluttertoast.showToast(msg: e.toString());
      return false;
    }
  }

  Future<bool> completeService(
    BuildContext context, {
    required Map<String, dynamic> data,
  }) async {
    emit(state.copyWith(isCompleteServiceLoading: true));
    try {
      VisitorsServiceCompleteResponseModel? response = await _serviceRepo
          .completeService(data: data)
          .onError((error, stackTrace) {
        emit(state.copyWith(isCompleteServiceLoading: false));
        Fluttertoast.showToast(
          msg: error.toString(),
        );
        return null;
      });
      emit(state.copyWith(isCompleteServiceLoading: false));
      // log("Service model RESPONSES:::: ${response?.toJson()}");
      if (response != null && response.status == 'success') {
        Fluttertoast.showToast(
            msg: AppUtils.languageTranslate('serviceCompletedSuccessfully'));
        if (context.mounted) {
          context.read<ServiceCubit>().getServices();
          Navigator.pop(context);
        }
        return true;
      } else {
        Fluttertoast.showToast(
            msg: AppUtils.languageTranslate(
                'somethingWentWrongWhileAddingCompletingServices'));
        return false;
      }
    } catch (e) {
      emit(state.copyWith(isCompleteServiceLoading: false));
      Fluttertoast.showToast(msg: e.toString());
      // log('cubit call ${e.toString()}');
      return false;
    }
  }

  Future<bool> completeAccessDeviceService(BuildContext context,
      {required Map<String, dynamic> data, required int? serviceId}) async {
    emit(state.copyWith(isCompleteServiceLoading: true));
    try {
      VisitorsServiceCompleteResponseModel? response = await _serviceRepo
          .completeAccessDeviceService(data: data, serviceId: serviceId)
          .onError((error, stackTrace) {
        emit(state.copyWith(isCompleteServiceLoading: false));
        Fluttertoast.showToast(
          msg: error.toString(),
        );
        return null;
      });
      emit(state.copyWith(isCompleteServiceLoading: false));
      // log("Service model RESPONSES:::: ${response?.toJson()}");
      if (response != null && response.status == 'success') {
        Fluttertoast.showToast(
            msg: AppUtils.languageTranslate('serviceCompletedSuccessfully'));
        if (context.mounted) {
          if (context.mounted) {
            context.read<ServiceCubit>().getServices();
            Navigator.pop(context);
          }
        }
        return true;
      } else {
        Fluttertoast.showToast(
            msg: AppUtils.languageTranslate(
                'somethingWentWrongWhileAddingCompletingServices'));
        return false;
      }
    } catch (e) {
      emit(state.copyWith(isCompleteServiceLoading: false));
      Fluttertoast.showToast(msg: e.toString());
      // log('cubit call ${e.toString()}');
      return false;
    }
  }

  Future<bool> clearPayment(
    BuildContext context, {
    required int? id,
    required Map<String, dynamic> data,
    required String? filePath,
  }) async {
    emit(state.copyWith(isClearPaymentLoading: true));

    if (filePath?.isEmpty ?? true) {
      Fluttertoast.showToast(
          msg: AppUtils.languageTranslate('pleaseSelectAFile'));
      emit(state.copyWith(isClearPaymentLoading: false));
      return false;
    }
    List<http.MultipartFile> multipartFiles = [];
    if (filePath?.isNotEmpty ?? false) {
      multipartFiles.add(
        await http.MultipartFile.fromPath('file', filePath!),
      );
    }

    final response = await _paymentRepo
        .clearPayment(
      id: id,
      data: data,
      files: multipartFiles,
    )
        .onError((error, stackTrace) {
      emit(state.copyWith(isClearPaymentLoading: false));
      Fluttertoast.showToast(msg: error.toString());
      return null;
    });

    emit(state.copyWith(isClearPaymentLoading: false));

    if (response != null && response.status == 'success') {
      Fluttertoast.showToast(
          msg: AppUtils.languageTranslate('paymentClearedSuccessfully'));
      return true;
    }

    Fluttertoast.showToast(
        msg: AppUtils.languageTranslate('somethingWentWrong'));
    return false;
  }
}
