import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tour_and_travel/models/send_package_request.dart';
import 'package:tour_and_travel/services/package_service.dart';

part 'send_package_event.dart';
part 'send_package_state.dart';

class SendPackageBloc extends Bloc<SendPackageEvent, SendPackageState> {
  final PackageService service;
  SendPackageBloc(this.service) : super(SendPackageInitial()) {
    on<DoSendPackageEvent>((event, emit) async {
      emit(SendPackageLoading());
      try {
        final result = await service.sendPackage(event.request);
        emit(SendPackageSuccess(isSuccess: result));
      } catch (e) {
        emit(SendPackageFailed(message: e.toString()));
      }
    });
  }
}
