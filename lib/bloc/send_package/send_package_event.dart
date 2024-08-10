part of 'send_package_bloc.dart';

sealed class SendPackageEvent extends Equatable {
  const SendPackageEvent();

  @override
  List<Object> get props => [];
}

class DoSendPackageEvent extends SendPackageEvent {
  final SendPackageRequest request;
  const DoSendPackageEvent(this.request);
}
