part of 'get_tickets_bloc.dart';

sealed class GetTicketsEvent extends Equatable {
  const GetTicketsEvent();

  @override
  List<Object> get props => [];
}

class DoGetTicketsEvent extends GetTicketsEvent {
  const DoGetTicketsEvent();
}
