import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../model/service/service_details_model.dart';
import '../../../model/service/service_details_response_model.dart';
import '../../../repo/services/services_repo.dart';
import '../../../repo/services/services_repo_impl.dart';

part 'service_details_state.dart';

class ServiceDetailsCubit extends Cubit<ServiceDetailsState> {
  ServiceDetailsCubit() : super(ServiceDetailsState());
  final ServiceRepo _serviceRepo = ServiceRepoImpl();

  Future<ServiceDetailsResponseModel?> getServiceDetails() async {
    emit(state.copyWith(isLoading: true));
    ServiceDetailsResponseModel? response =
    await _serviceRepo.getServiceDetails().onError(
          (error, stackTrace) {
        emit(state.copyWith(isLoading: false));
        Fluttertoast.showToast(
          msg: error.toString(),
        );
        throw error!;
      },
    );
    if (response != null && response.status == 'success') {
      emit(state.copyWith(isLoading: false));
      emit(state.copyWith(serviceDetails: response.record,isLoading: false));
    } else {
      Fluttertoast.showToast(
          msg: 'Something went wrong while fetching service details');
    }
    emit(state.copyWith(isLoading: false));
    return null;
  }
}
