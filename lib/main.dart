import 'package:display_bandwidth_calc/screens/tcon_input_screen.dart';
import 'package:flutter/material.dart';
import 'screens/memory_screen.dart';
import 'widget/bottom_bar.dart';
import 'package:provider/provider.dart';
import 'package:display_bandwidth_calc/calculators/bps_calculator.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BpsCalc()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late TabController controller;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BpsCalc>(
        create: (_) => BpsCalc(),
        child: MaterialApp(
          title: 'Display Calculator',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: DefaultTabController(
            length: 4,
            child: Scaffold(
              body: TabBarView(
                // physics: NeverScrollableScrollPhysics(),
                children: [
                  TconInputScreen(),
                  MemoryScreen(),
                  Container(),
                  Container(),
                ],
              ),
              bottomNavigationBar: Bottom(),
            ),
          ),
        ));
  }
}
