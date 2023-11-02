import 'package:bloc/bloc.dart';

int cubitMain() {
  print('---------CUBIT-----------');

  final cubit = CounterCubit(1);

  print(cubit.state);

  cubit.increment();

  print(cubit.state);

  cubit.close();
  return cubit.state;
}

class CounterCubit extends Cubit<int> {
  CounterCubit(int initialState) : super(initialState);

  void increment() => emit(state + 1);
}
