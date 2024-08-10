import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tour_and_travel/models/register_response.dart';
import '../../models/register_request.dart';
import '../../services/auth_service.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthService service;
  RegisterBloc(this.service) : super(RegisterInitial()) {
    on<DoRegisterEvent>((event, emit) async {
      emit(RegisterLoading());
      try {
        final result = await service.register(event.request);
        emit(RegisterSuccess(data: result));
      } catch (e) {
        emit(RegisterFailed(message: e.toString()));
      }
    });
  }
}
