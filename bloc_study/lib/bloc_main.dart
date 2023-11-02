// the events which 'CounterBloc' will react to
// evento o qual o bloc Contador vai reagir
import 'package:bloc/bloc.dart';

sealed class CounterEvent {}

class CounterIncrementPressed extends CounterEvent {}

class CounterBloc extends Bloc<CounterEvent, int> {
  // the initial state is defined in this constructor it is 0.
  CounterBloc() : super(0) {
    // When a CounterIncrementPressd event is added, the current ´state´ of the
    // bloc is accessed via the `state` property
    on<CounterIncrementPressed>((event, emit) {
      addError(Exception('increment error!'), StackTrace.current);
      emit(state + 1);
    });
  }
}

Future<int> blocMain() async {
  print('------------BLOC---------');

  final bloc = CounterBloc();

  final subscription = bloc.stream.listen(print);

  bloc.add(CounterIncrementPressed());

  await Future<void>.delayed(Duration.zero);

  await subscription.cancel();

  await bloc.close();

  return bloc.state;
}
