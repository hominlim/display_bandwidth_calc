import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
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
  double _vth_data_compression_ratio = 50;
  double _mobility_data_compression_ratio = 50;
  double _oled_data_compression_ratio = 50;

  final _vthController = TextEditingController(text: "10");
  final _mobilityController = TextEditingController(text: "6");
  final _oledController = TextEditingController(text: "8");

  @override
  bool wantKeepAlive = true;

  @override
  void initState() {
    super.initState();
    context.read<BpsCalc>().initDisplay3(
        _vth_data_compression_ratio,
        double.parse(_vthController.text),
        _mobility_data_compression_ratio,
        double.parse(_mobilityController.text),
        _oled_data_compression_ratio,
        double.parse(_oledController.text));
  }

  void refreshUI() {
    context.read<BpsCalc>().vthDataUpdate(
        _vth_data_compression_ratio, double.parse(_vthController.text));

    context.read<BpsCalc>().mobilityDataUpdate(_mobility_data_compression_ratio,
        double.parse(_mobilityController.text));
    context.read<BpsCalc>().oledDataUpdate(
        _oled_data_compression_ratio, double.parse(_oledController.text));

    context.read<BpsCalc>().frameMemStorageCalc();
    context.read<BpsCalc>().initDisplay3(
        _vth_data_compression_ratio,
        double.parse(_vthController.text),
        _mobility_data_compression_ratio,
        double.parse(_mobilityController.text),
        _oled_data_compression_ratio,
        double.parse(_oledController.text));
    context.read<BpsCalc>().bpsCalculate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Display Calculator'),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
              margin: EdgeInsets.only(left: 10, right: 30),
              child: Column(children: [
                SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Compensation Data',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
                SizedBox(
                  height: 60,
                ),
                Row(
                  children: [
                    SfSlider(
                      value: _vth_data_compression_ratio,
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
                          _vth_data_compression_ratio = value;
                          refreshUI();
                        });
                      },
                    ),
                    SizedBox(
                      width: 100.0,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "Vth",
                          border: OutlineInputBorder(),
                          isDense: true,
                          contentPadding: EdgeInsets.all(8),
                        ),
                        controller: _vthController,
                        onChanged: (value) {
                          if (value == '') {
                          } else
                            refreshUI();
                        },
                      ),
                    ),
                    Text('  bits'),
                  ],
                ),
                SizedBox(
                  height: 60,
                ),
                Row(
                  children: [
                    SfSlider(
                      value: _mobility_data_compression_ratio,
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
                          _mobility_data_compression_ratio = value;
                          refreshUI();
                        });
                      },
                    ),
                    SizedBox(
                      width: 100.0,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "mobility",
                          border: OutlineInputBorder(),
                          isDense: true,
                          contentPadding: EdgeInsets.all(8),
                        ),
                        controller: _mobilityController,
                        onChanged: (value) {
                          if (value == '') {
                          } else
                            refreshUI();
                        },
                      ),
                    ),
                    Text('  bits'),
                  ],
                ),
                SizedBox(
                  height: 60,
                ),
                Row(
                  children: [
                    SfSlider(
                      value: _oled_data_compression_ratio,
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
                          _oled_data_compression_ratio = value;
                          refreshUI();
                        });
                      },
                    ),
                    SizedBox(
                      width: 100.0,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "OLED",
                          border: OutlineInputBorder(),
                          isDense: true,
                          contentPadding: EdgeInsets.all(8),
                        ),
                        controller: _oledController,
                        onChanged: (value) {
                          if (value == '') {
                          } else
                            refreshUI();
                        },
                      ),
                    ),
                    Text('  bits'),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  '${context.watch<BpsCalc>().ddr_comp_data.ceil()} ea of DDR Memory required \nwith ${(context.watch<BpsCalc>().margin_comp_data * 100).toStringAsFixed(2)}% of margin',
                  style: const TextStyle(fontSize: 20),
                ),
              ])),
        ));
  }
}
