import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContadorEvento {}

class ContadorSomarPressionado extends ContadorEvento {}

class ContadorSubtrairPressionado extends ContadorEvento {}

class ContadorBloc extends Bloc<ContadorEvento, int> {
  final ContadorRepositorio repositorioContador = ContadorRepositorio();

  ContadorBloc() : super(0) {
    on<ContadorSomarPressionado>((event, emit) {
      final novoContagem = state + 1;
      emit(novoContagem);
      repositorioContador.atualizaContagem(novoContagem);
    });

    on<ContadorSubtrairPressionado>((event, emit) {
      final novoContagem = state - 1;
      emit(novoContagem);
      repositorioContador.atualizaContagem(novoContagem);
    });
  }
}

class ContadorRepositorio {
  int _contador = 0;

  Future<int> fetchContador() async {
    await Future.delayed(const Duration(seconds: 3));
    return _contador;
  }

  void atualizaContagem(int novaConta) {
    _contador = novaConta;
  }
}

void main() => runApp(const AppContador());

class AppContador extends StatelessWidget {
  const AppContador({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => ContadorBloc(),
        child: const CounterPage(),
      ),
    );
  }
}

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: BlocBuilder<ContadorBloc, int>(
        builder: (context, count) {
          return Center(
            child: Text(
              '$count',
              style: const TextStyle(fontSize: 24.0),
            ),
          );
        },
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () =>
                  context.read<ContadorBloc>().add(ContadorSomarPressionado()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              child: const Icon(Icons.remove),
              onPressed: () => context
                  .read<ContadorBloc>()
                  .add(ContadorSubtrairPressionado()),
            ),
          ),
        ],
      ),
    );
  }
}
