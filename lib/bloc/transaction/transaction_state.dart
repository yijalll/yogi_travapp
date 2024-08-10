part of 'transaction_bloc.dart';

sealed class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionSuccess extends TransactionState {
  final List<TransactionHistory> data;

  const TransactionSuccess({
    required this.data,
  });
}

class TransactionFailed extends TransactionState {
  final String message;

  const TransactionFailed({
    required this.message,
  });
}
