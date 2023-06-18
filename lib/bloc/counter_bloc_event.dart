part of 'counter_bloc_bloc.dart';

@immutable
abstract class CounterBlocEvent {}

class CounterBlocIncremented extends CounterBlocEvent {}

class CounterBlocDecremented extends CounterBlocEvent {}
