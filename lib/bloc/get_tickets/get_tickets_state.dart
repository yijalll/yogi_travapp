part of 'get_tickets_bloc.dart';

sealed class GetTicketsState extends Equatable {
  const GetTicketsState();

  @override
  List<Object> get props => [];
}

class GetTicketsInitial extends GetTicketsState {}

class GetTicketsLoading extends GetTicketsState {}

class GetTicketsSuccess extends GetTicketsState {
  final List<Ticket> data;

  const GetTicketsSuccess({
    required this.data,
  });
}

class GetTicketsFailed extends GetTicketsState {
  final String message;

  const GetTicketsFailed({
    required this.message,
  });
}
