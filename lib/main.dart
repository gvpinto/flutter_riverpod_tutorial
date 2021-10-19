import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_tutorial/clock.dart';
import 'package:intl/intl.dart';

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

final clockProvider = StateNotifierProvider<Clock, DateTime>((ref) {
  return Clock();
});

class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // this line is used to watch the provider's *state*
    // to get an instance of the clock itself,
    // call `ref.watch(clockProvider.notifier)`
    final currentTime = ref.watch(clockProvider);
    // format the time as `hh:mm:ss`
    // ref.watch(clockProvider) returns the provider's state.
    // To get access to the underlying state notifier object,
    // call ref.watch(clockProvider.notifier) instead.
    final timeFormatted = DateFormat.Hms().format(currentTime);

    return Scaffold(
        body: Center(
      child: Text(
        timeFormatted,
        style: Theme.of(context).textTheme.headline4,
      ),
    ));
  }
}
