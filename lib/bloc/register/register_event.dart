part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class DoRegisterEvent extends RegisterEvent {
  final RegisterRequest request;
  const DoRegisterEvent(this.request);
}
