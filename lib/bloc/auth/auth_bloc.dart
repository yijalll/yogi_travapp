import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tour_and_travel/models/login_request.dart';
import 'package:tour_and_travel/models/register_request.dart';
import 'package:tour_and_travel/models/user_response.dart';

import '../../services/auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService service;
  AuthBloc(this.service) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final result = await service.login(event.request);
        emit(AuthSuccess(data: result.data!));
      } catch (e) {
        emit(AuthFailed(message: e.toString()));
      }
    });

    on<EditProfileEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final result = await service.editProfile(event.request);
        emit(AuthSuccess(data: result.data!));
      } catch (e) {
        emit(AuthFailed(message: e.toString()));
      }
    });

    on<GetAuthEvent>((event, emit) async {
      emit(AuthLoading());
      emit(AuthSuccess(data: event.data));
    });
  }
}
