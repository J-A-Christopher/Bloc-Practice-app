import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_bloc_event.dart';
part 'counter_bloc_state.dart';

class CounterBlocBloc extends Bloc<CounterBlocEvent, int> {
  CounterBlocBloc() : super(0) {
    on<CounterBlocEvent>((event, emit) {
      // TODO: implement event handler
      if (event is CounterBlocIncremented) {
        emit(state + 1);
      }

      if (event is CounterBlocDecremented) {
        emit(state - 1);
      }
    });
  }
}
