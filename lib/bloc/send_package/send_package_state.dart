part of 'send_package_bloc.dart';

sealed class SendPackageState extends Equatable {
  const SendPackageState();

  @override
  List<Object> get props => [];
}

class SendPackageInitial extends SendPackageState {}

class SendPackageLoading extends SendPackageState {}

class SendPackageSuccess extends SendPackageState {
  final bool isSuccess;

  const SendPackageSuccess({
    required this.isSuccess,
  });
}

class SendPackageFailed extends SendPackageState {
  final String message;

  const SendPackageFailed({
    required this.message,
  });
}
