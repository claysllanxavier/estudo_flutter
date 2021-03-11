import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
}

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(),
      child: CounterView(),
    );
  }
}

class CounterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nosso contador'),
      ),
      body: Center(
        child: Text(
          '0',
          style: textTheme.headline2,
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => context.bloc<CounterCubit>().increment(),
            child: const Icon(Icons.add),
          ),
          SizedBox(
            height: 8,
          ),
          FloatingActionButton(
            onPressed: () => decrement(),
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
