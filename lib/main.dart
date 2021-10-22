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

final futureProvider = FutureProvider<int>((ref) {
  return Future.value(36);
});

final streamProvider = StreamProvider<int>((ref) {
  return Stream.fromIterable([36, 72]);
});

class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streamAsyncValue = ref.watch(streamProvider);
    // final futureAsyncValue = ref.watch(futureProvider); // same syntax
    return Scaffold(
      body: Center(
        child: streamAsyncValue.when(
          data: (data) => Text('Value: $data'),
          loading: (previous) => const CircularProgressIndicator(),
          error: (e, st, previous) => Text('Error: $e'),
        ),
      ),
    );
  }
}
