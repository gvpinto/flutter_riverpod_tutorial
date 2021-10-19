import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Test App",
      home: MyHomePage(),
    );
  }
}

final counterStateProvider = StateProvider<int>((ref) {
  return 0;
});

class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. watch the counterStateProvider
    final counter = ref.watch(counterStateProvider);

    return Scaffold(
      body: Center(
        // 2. this time we read counter.state
        child: Text('Value: ${counter.state}',
            style: Theme.of(context).textTheme.headline4),
      ),
      floatingActionButton: FloatingActionButton(
        // access the provider via ref.read(), then increment its state.
        // We should always use ref.read() rather than ref.watch()
        // to access providers inside a callback
        onPressed: () => ref.read(counterStateProvider).state++,
        child: Icon(Icons.add),
      ),
    );
  }
}
