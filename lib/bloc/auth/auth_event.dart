part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final LoginRequest request;
  const LoginEvent(this.request);
}

class EditProfileEvent extends AuthEvent {
  final RegisterRequest request;
  const EditProfileEvent(this.request);
}

class GetAuthEvent extends AuthEvent {
  final User data;
  const GetAuthEvent(this.data);
}
