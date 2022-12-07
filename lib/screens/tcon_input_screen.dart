import 'dart:ffi';
import 'package:display_bandwidth_calc/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:display_bandwidth_calc/calculators/bps_calculator.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class TconInputScreen extends StatefulWidget {
  const TconInputScreen({Key? key}) : super(key: key);

  @override
  State<TconInputScreen> createState() => _TconInputScreenState();
}

class _TconInputScreenState extends State<TconInputScreen> {
  BpsCalc bps = BpsCalc();

  final columnController = TextEditingController(text: "3840");
  final rowController = TextEditingController(text: "2160");
  final fpsController = TextEditingController(text: "120");
  final colorController = TextEditingController(text: "3");
  final dataWidthController = TextEditingController(text: "10");
  final ddrSpeedController = TextEditingController(text: "1866");
  final ddrWidthController = TextEditingController(text: "16");

  dynamic _horizontalTimeSliderValue = 10;

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

    context.read<BpsCalc>().horizontalMarginUpdate(_horizontalTimeSliderValue);

    context.read<BpsCalc>().bpsCalculate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bandwidth Calculator'),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 10, right: 30),
        child: Column(
          children: [
            const SizedBox(
              height: 16.0,
            ),
            const Text(
              'T-Con Input',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Row(
              children: [
                Expanded(
                    child: TextField(
                  decoration: const InputDecoration(labelText: "Column"),
                  controller: columnController,
                  onChanged: (value) {
                    refreshUI();
                  },
                )),
                Expanded(
                    child: TextField(
                  decoration: const InputDecoration(labelText: "Row"),
                  controller: rowController,
                  onChanged: (value) {
                    refreshUI();

                    // context
                    //     .read<BpsCalc>()
                    //     .rowUpdate(double.parse(rowController.text));
                  },
                )),
                Expanded(
                    child: TextField(
                  decoration: const InputDecoration(labelText: "FPS"),
                  controller: fpsController,
                  onChanged: (value) {
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
                    refreshUI();
                  },
                )),
                Expanded(
                    child: TextField(
                  decoration: const InputDecoration(labelText: "Colors"),
                  controller: colorController,
                  onChanged: (value) {
                    refreshUI();
                  },
                )),
                Expanded(
                  child: Text(
                      '${NumberFormat('##.###').format(context.watch<BpsCalc>().bps_calc_result_gibps)} Gibps',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 17,
                      )),
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
                    refreshUI();
                  },
                )),
                Expanded(
                    child: TextField(
                  decoration: const InputDecoration(labelText: "Width by"),
                  controller: ddrWidthController,
                  onChanged: (value) {
                    refreshUI();
                  },
                )),
                Expanded(
                  child: Text(
                      '${NumberFormat('##.###').format(context.watch<BpsCalc>().bps_calc_ddr)} Gibps',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 17,
                      )),
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            const SizedBox(
              height: 50.0,
            ),
            Row(
              children: [
                SfSlider(
                  value: _horizontalTimeSliderValue,
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
                    // setState(() {
                    _horizontalTimeSliderValue = value;
                    refreshUI();
                    // });
                  },
                ),
                Text(
                  '${NumberFormat('##.###').format(context.watch<BpsCalc>().horizontal_time)} us',
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
            const SizedBox(
              height: 50.0,
            ),
            const SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}
