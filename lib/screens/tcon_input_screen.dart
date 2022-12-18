import 'dart:ffi';
import 'package:display_bandwidth_calc/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:display_bandwidth_calc/calculators/bps_calculator.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:toggle_switch/toggle_switch.dart';

class TconInputScreen extends StatefulWidget {
  const TconInputScreen({Key? key}) : super(key: key);

  @override
  State<TconInputScreen> createState() => _TconInputScreenState();
}

class _TconInputScreenState extends State<TconInputScreen>
    with AutomaticKeepAliveClientMixin {
  final columnController = TextEditingController(text: "3840");
  final rowController = TextEditingController(text: "2160");
  final fpsController = TextEditingController(text: "120");
  final colorController = TextEditingController(text: "3");
  final dataWidthController = TextEditingController(text: "10");
  final ddrSpeedController = TextEditingController(text: "1866");
  final ddrWidthController = TextEditingController(text: "16");

  double horizontalTimeSliderValue = 10;
  double _storage_video_compression_ratio = 50;

  @override
  bool wantKeepAlive = true;

  @override
  void initState() {
    super.initState();
    context.read<BpsCalc>().initDisplay(
        double.parse(columnController.text),
        double.parse(rowController.text),
        double.parse(fpsController.text),
        double.parse(dataWidthController.text),
        double.parse(colorController.text),
        double.parse(ddrSpeedController.text),
        double.parse(ddrWidthController.text));
    context.read<BpsCalc>().initDisplay2(
          _storage_video_compression_ratio,
        );
  }

  void refreshUI() {
    context.read<BpsCalc>().columnUpdate(double.parse(columnController.text));
    context.read<BpsCalc>().rowUpdate(double.parse(rowController.text));
    context.read<BpsCalc>().fpsUpdate(double.parse(fpsController.text));
    context
        .read<BpsCalc>()
        .dataWidthUpdata(double.parse(dataWidthController.text));
    context.read<BpsCalc>().colorUpdate(double.parse(colorController.text));

    context
        .read<BpsCalc>()
        .ddrSpeedUpdate(double.parse(ddrSpeedController.text));
    context
        .read<BpsCalc>()
        .ddrWidthUpdate(double.parse(ddrWidthController.text));

    context.read<BpsCalc>().horizontalMarginUpdate(horizontalTimeSliderValue);

    context.read<BpsCalc>().bpsCalculate();
    context.read<BpsCalc>().frameMemStorageCalc();
    context.read<BpsCalc>().frameMemoryUpdate(_storage_video_compression_ratio);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Display Calculator'),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 10, right: 30),
        child: Column(
          children: [
            const SizedBox(
              height: 15.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Input information',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: TextField(
                  decoration: const InputDecoration(labelText: "Column"),
                  controller: columnController,
                  onChanged: (value) {
                    if (value == '') {
                    } else
                      refreshUI();
                  },
                )),
                Expanded(
                    child: TextField(
                  decoration: const InputDecoration(labelText: "Row"),
                  controller: rowController,
                  onChanged: (value) {
                    if (value == '') {
                    } else
                      refreshUI();
                  },
                )),
                Expanded(
                    child: TextField(
                  decoration: const InputDecoration(labelText: "FPS"),
                  controller: fpsController,
                  onChanged: (value) {
                    if (value == '') {
                    } else
                      refreshUI();
                  },
                )),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Expanded(
                    child: TextField(
                  decoration: const InputDecoration(labelText: "Data Width"),
                  controller: dataWidthController,
                  onChanged: (value) {
                    if (value == '') {
                    } else
                      refreshUI();
                  },
                )),
                Expanded(
                    child: TextField(
                  decoration: const InputDecoration(labelText: "Colors"),
                  controller: colorController,
                  onChanged: (value) {
                    if (value == '') {
                    } else {
                      refreshUI();
                    }
                  },
                )),
                Expanded(
                  child: Column(
                    children: [
                      Text('Video B/W',
                          style: const TextStyle(
                            fontSize: 15,
                          )),
                      Text(
                          '${NumberFormat('##.##').format(context.watch<BpsCalc>().bps_calc_result_gibps)} Gibps',
                          style: const TextStyle(
                            fontSize: 17,
                            color: Colors.blue,
                          )),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Expanded(
                    child: TextField(
                  decoration: const InputDecoration(labelText: "DDR speed"),
                  controller: ddrSpeedController,
                  onChanged: (value) {
                    if (value == '') {
                    } else {
                      refreshUI();
                    }
                  },
                )),
                Expanded(
                    child: TextField(
                  decoration: const InputDecoration(labelText: "Width by"),
                  controller: ddrWidthController,
                  onChanged: (value) {
                    if (value == '') {
                    } else {
                      refreshUI();
                    }
                  },
                )),
                Expanded(
                  child: Column(
                    children: [
                      Text('DDR B/W',
                          style: const TextStyle(
                            fontSize: 15,
                          )),
                      Text(
                          '${NumberFormat('##.##').format(context.watch<BpsCalc>().bps_calc_ddr)} Gibps',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 17, color: Colors.blue)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30.0,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Horizontal time',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Text('margin\n(%)',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 17,
                        )),
                    SfSlider(
                      value: horizontalTimeSliderValue,
                      min: 0,
                      max: 20,
                      showTicks: true,
                      showLabels: true,
                      showDividers: true,
                      interval: 10,
                      stepSize: 1,
                      enableTooltip: true,
                      shouldAlwaysShowTooltip: true,
                      onChanged: (value) {
                        setState(() {
                          horizontalTimeSliderValue = value;
                          refreshUI();
                        });
                      },
                    ),
                  ],
                ),
                Text(
                  '1H time : ${NumberFormat('##.###').format(context.watch<BpsCalc>().horizontal_time)} us',
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
            const SizedBox(
              height: 30.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Video Frame Buffer',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
            // const SizedBox(
            //   height: 10.0,
            // ),
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     ToggleSwitch(
            //       minWidth: 100.0,
            //       minHeight: 30,
            //       initialLabelIndex: 0,
            //       cornerRadius: 15.0,
            //       activeFgColor: Colors.white,
            //       inactiveBgColor: Colors.grey,
            //       inactiveFgColor: Colors.white,
            //       totalSwitches: 2,
            //       labels: ['Use', 'Not Use'],
            //       activeBgColors: [
            //         [Colors.blue],
            //         [Colors.blue],
            //       ],
            //       onToggle: (index) {
            //         print('switched to: $index');
            //       },
            //     ),
            //   ],
            // ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('compression\n(%)',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 17,
                        )),
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
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Storage',
                      style: const TextStyle(fontSize: 15),
                    ),
                    Text(
                      '${NumberFormat('##.##').format(context.watch<BpsCalc>().storage_video_result_mibits)} Mbits',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            // Row(
            //   children: [
            //     Text(
            //       '${NumberFormat('##.###').format(context.watch<BpsCalc>().bw_frame_buffer)} Gibps',
            //       style: const TextStyle(fontSize: 20),
            //     ),
            //   ],
            // ),
            SizedBox(
              height: 20,
            ),
            Text(
              '${context.watch<BpsCalc>().ddr_frame_buffer.ceil()} ea of DDR Memory required \nwith ${(context.watch<BpsCalc>().margin_frame_buffer * 100).toStringAsFixed(2)}% of margin',
              style: const TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }
}
