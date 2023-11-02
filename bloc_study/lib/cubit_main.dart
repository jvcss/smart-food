import 'package:bloc/bloc.dart';

int cubitMain() {
  print('---------CUBIT-----------');

  final cubit = CounterCubit();

  print(cubit.state);

  cubit.increment();

  print(cubit.state);

  cubit.close();
  return cubit.state;
}

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() => emit(state + 1);
}
