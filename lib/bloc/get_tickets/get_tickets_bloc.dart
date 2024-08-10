import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tour_and_travel/models/ticket_response.dart';
import 'package:tour_and_travel/services/transaction_service.dart';

part 'get_tickets_event.dart';
part 'get_tickets_state.dart';

class GetTicketsBloc extends Bloc<GetTicketsEvent, GetTicketsState> {
  final TransactionService service;
  GetTicketsBloc(this.service) : super(GetTicketsInitial()) {
    on<DoGetTicketsEvent>((event, emit) async {
      emit(GetTicketsLoading());
      try {
        final result = await service.getTickets();
        emit(GetTicketsSuccess(data: result));
      } catch (e) {
        emit(GetTicketsFailed(message: e.toString()));
      }
    });
  }
}
