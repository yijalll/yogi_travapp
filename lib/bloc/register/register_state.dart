part of 'register_bloc.dart';

sealed class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final RegisterResponse data;

  const RegisterSuccess({
    required this.data,
  });
}

class RegisterFailed extends RegisterState {
  final String message;

  const RegisterFailed({
    required this.message,
  });
}
