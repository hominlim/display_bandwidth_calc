import 'dart:ffi';
import 'package:display_bandwidth_calc/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:display_bandwidth_calc/calculators/bps_calculator.dart';
import 'package:provider/provider.dart';

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

  @override
  void initState() {
    super.initState();

    bps.columnUpdate(double.parse(columnController.text));
    bps.rowUpdate(double.parse(rowController.text));
    bps.fpsUpdate(double.parse(fpsController.text));
    bps.dataWidthUpdata(double.parse(colorController.text));
    bps.colorUpdate(double.parse(dataWidthController.text));
    bps.bpsCalculate();
  }

  void refreshUI() {
    context.read<BpsCalc>().columnUpdate(double.parse(columnController.text));
    context.read<BpsCalc>().rowUpdate(double.parse(rowController.text));
    context.read<BpsCalc>().fpsUpdate(double.parse(fpsController.text));
    context
        .read<BpsCalc>()
        .dataWidthUpdata(double.parse(dataWidthController.text));
    context.read<BpsCalc>().colorUpdate(double.parse(colorController.text));
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
                    // context.read<BpsCalc>().columnUpdate(double.parse(columnController.text));
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
            // Row(
            //   children: [
            //     Expanded(
            //         child: TextField(
            //       decoration: const InputDecoration(labelText: "DDR speed"),
            //       controller: _ddrSpeedController,
            //       onChanged: (value) {
            //         bpsCalcResult();
            //       },
            //     )),
            //     Expanded(
            //         child: TextField(
            //       decoration: const InputDecoration(labelText: "Width by"),
            //       controller: _ddrWidthController,
            //       onChanged: (value) {
            //         bpsCalcResult();
            //       },
            //     )),
            //     Expanded(
            //       child: Text(
            //           '${NumberFormat('##.###').format(bps_calc_ddr)} Gibps',
            //           textAlign: TextAlign.center,
            //           style: const TextStyle(
            //             fontSize: 17,
            //           )),
            //     ),
            //   ],
            // ),
            // const SizedBox(
            //   height: 10.0,
            // ),
            // const SizedBox(
            //   height: 50.0,
            // ),
            // Row(
            //   children: [
            //     SfSlider(
            //       value: _horizontalTimeSliderValue,
            //       min: 0,
            //       max: 20,
            //       showTicks: true,
            //       showLabels: true,
            //       showDividers: true,
            //       interval: 10,
            //       stepSize: 1,
            //       enableTooltip: true,
            //       shouldAlwaysShowTooltip: true,
            //       onChanged: (value) {
            //         setState(() {
            //           _horizontalTimeSliderValue = value;
            //           bpsCalcResult();
            //         });
            //       },
            //     ),
            //     Text(
            //       '${NumberFormat('##.###').format(horizontal_time)} us',
            //       style: const TextStyle(fontSize: 20),
            //     ),
            //   ],
            // ),
            // const SizedBox(
            //   height: 50.0,
            // ),
            // const SizedBox(
            //   height: 10.0,
            // ),
          ],
        ),
      ),
    );
  }
}
