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

class _MemoryScreenState extends State<MemoryScreen>
    with AutomaticKeepAliveClientMixin {
  BpsCalc bps = BpsCalc();

  bool _is_frame_buffer = false;
  double _storage_video_compression_ratio = 50;

  @override
  bool wantKeepAlive = true;

  @override
  void initState() {
    context.read<BpsCalc>().initDisplay2(
          _storage_video_compression_ratio,
        );
  }

  void refreshUI() {
    context.read<BpsCalc>().frameMemoryUpdate(_storage_video_compression_ratio);
    context.read<BpsCalc>().frameMemStorageCalc();
    context.read<BpsCalc>().bpsCalculate();
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
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ToggleSwitch(
                    minWidth: 100.0,
                    minHeight: 30,
                    initialLabelIndex: 0,
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
                ],
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
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    '${NumberFormat('##.###').format(context.watch<BpsCalc>().bw_frame_buffer)} Gibps',
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '${context.watch<BpsCalc>().ddr_frame_buffer.ceil()} ea of DDR Memory required \nwith ${(context.watch<BpsCalc>().margin_frame_buffer * 100).toStringAsFixed(2)}% of margin',
                style: const TextStyle(fontSize: 20),
              )
            ])));
  }
}
