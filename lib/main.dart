import 'package:display_bandwidth_calc/screens/tcon_input_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/memory_screen.dart';
import 'widget/bottom_bar.dart';
import 'package:provider/provider.dart';
import 'package:display_bandwidth_calc/calculators/bps_calculator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Calculation()),
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
    return ChangeNotifierProvider<Calculation>(
        create: (_) => Calculation(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Display Calculator',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: DefaultTabController(
            length: 2,
            child: Scaffold(
              body: TabBarView(
                physics: ClampingScrollPhysics(),
                // NeverScrollableScrollPhysics(),
                children: [
                  TconInputScreen(),
                  MemoryScreen(),
                ],
              ),
              bottomNavigationBar: Bottom(),
            ),
          ),
        ));
  }
}
