part of 'transaction_bloc.dart';

sealed class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class GetTransactionsEvent extends TransactionEvent {
  const GetTransactionsEvent();
}

class CreateTransactionEvent extends TransactionEvent {
  final TransactionRequest request;
  const CreateTransactionEvent(this.request);
}
