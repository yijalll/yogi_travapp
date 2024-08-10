import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tour_and_travel/models/transaction_history_response.dart';
import 'package:tour_and_travel/models/transaction_request.dart';
import 'package:tour_and_travel/services/transaction_service.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionService service;
  TransactionBloc(this.service) : super(TransactionInitial()) {
    on<GetTransactionsEvent>((event, emit) async {
      emit(TransactionLoading());
      try {
        final result = await service.getTransactionHistories();
        emit(TransactionSuccess(data: result));
      } catch (e) {
        emit(TransactionFailed(message: e.toString()));
      }
    });

    on<CreateTransactionEvent>((event, emit) async {
      emit(TransactionLoading());
      try {
        await service.createTransaction(event.request);
        add(const GetTransactionsEvent());
      } catch (e) {
        emit(TransactionFailed(message: e.toString()));
      }
    });
  }
}
