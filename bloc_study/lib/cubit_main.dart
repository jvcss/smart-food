import 'package:bloc/bloc.dart';

Future<int> cubitMain() async {
  print('---------CUBIT-----------');

  final cubit = CounterCubit(1);

  final subscription = cubit.stream.listen(print);

  cubit.increment();

  await Future.delayed(Duration.zero);

  await subscription.cancel();

  cubit.close();
  return cubit.state;
}

class CounterCubit extends Cubit<int> {
  CounterCubit(int initialState) : super(initialState);

  void increment() {
    //addError(Exception('increment error!'), StackTrace.current);
    emit(state + 1);
  }
}
