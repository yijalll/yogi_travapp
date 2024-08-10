import 'package:bloc/bloc.dart';

class PageBloc extends Bloc<int, int> {
  PageBloc() : super(0) {
    on<int>((event, emit) => emit(event));
  }
}
