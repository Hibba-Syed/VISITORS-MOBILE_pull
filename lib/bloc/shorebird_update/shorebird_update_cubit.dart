import 'package:flutter_bloc/flutter_bloc.dart';

enum ShorebirdUpdateStatus { initial, updating, updated, error }

class UpdateCubit extends Cubit<ShorebirdUpdateStatus> {
  UpdateCubit() : super(ShorebirdUpdateStatus.initial);

  void startUpdate() => emit(ShorebirdUpdateStatus.updating);

  void finishUpdate() => emit(ShorebirdUpdateStatus.updated);

  void setError() => emit(ShorebirdUpdateStatus.error);
}
