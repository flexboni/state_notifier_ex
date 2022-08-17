import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';
import 'package:state_notifier_ex/providers/bg_color.dart';
import 'package:state_notifier_ex/providers/counter.dart';
import 'package:state_notifier_ex/providers/customer_level.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StateNotifierProvider<BgColor, BgColorState>(create: (_) => BgColor()),
        StateNotifierProvider<Counter, CounterState>(create: (_) => Counter()),
        StateNotifierProvider<CustomerLevel, Level>(
            create: (_) => CustomerLevel()),
      ],
      builder: (context, _) {
        return MaterialApp(
          title: 'StateNotifier',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const MyHomePage(),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final colorState = context.watch<BgColorState>();
    final counterState = context.watch<CounterState>();
    final levelState = context.watch<Level>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('StateNotifier'),
        backgroundColor: colorState.color,
      ),
      backgroundColor: levelState == Level.bronze
          ? Colors.white
          : levelState == Level.silver
              ? Colors.grey
              : Colors.yellow,
      body: Center(
        child: Text(
          '${counterState.counter}',
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      floatingActionButton: Row(
        children: [
          FloatingActionButton(
            onPressed: () => context.read<Counter>().increment(),
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () => context.read<BgColor>().changeColor(),
            tooltip: 'Change Color',
            child: const Icon(Icons.color_lens_outlined),
          ),
        ],
      ),
    );
  }
}
