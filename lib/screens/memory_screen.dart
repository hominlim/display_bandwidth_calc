import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:display_bandwidth_calc/calculators/bps_calculator.dart';
import 'package:display_bandwidth_calc/main.dart';
import 'package:provider/provider.dart';

class MemoryScreen extends StatefulWidget {
  const MemoryScreen({Key? key}) : super(key: key);

  @override
  State<MemoryScreen> createState() => _MemoryScreenState();
}

class _MemoryScreenState extends State<MemoryScreen> {
  BpsCalc bps = BpsCalc();

  bool _is_frame_buffer = false;
  dynamic _storage_video_compression_ratio = 50;

  void refreshUI() {
    context.read<BpsCalc>().frameMemoryUpdate(_storage_video_compression_ratio);
    context.read<BpsCalc>().frameMemStorageCalc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Bandwidth Calculator'),
        ),
        body: Container(
            margin: EdgeInsets.only(left: 10, right: 30),
            child: Column(children: [
              ToggleSwitch(
                minWidth: 90.0,
                initialLabelIndex: 1,
                cornerRadius: 15.0,
                activeFgColor: Colors.white,
                inactiveBgColor: Colors.grey,
                inactiveFgColor: Colors.white,
                totalSwitches: 2,
                labels: ['Use', 'Not Use'],
                activeBgColors: [
                  [Colors.blue],
                  [Colors.blue],
                ],
                onToggle: (index) {
                  print('switched to: $index');
                },
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  SfSlider(
                    value: _storage_video_compression_ratio,
                    min: 0,
                    max: 100,
                    showTicks: true,
                    showLabels: true,
                    showDividers: true,
                    interval: 25,
                    stepSize: 1,
                    enableTooltip: true,
                    shouldAlwaysShowTooltip: true,
                    onChanged: (value) {
                      setState(() {
                        _storage_video_compression_ratio = value;
                        refreshUI();
                      });
                    },
                  ),
                  Text(
                    '${NumberFormat('##.###').format(context.watch<BpsCalc>().storage_video_result_mibits)} Mbits',
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ])));
  }
}
