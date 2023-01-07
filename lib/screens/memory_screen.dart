import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:display_bandwidth_calc/calculators/bps_calculator.dart';
import 'package:display_bandwidth_calc/screens/tcon_input_screen.dart';
import 'package:provider/provider.dart';

class MemoryScreen extends StatefulWidget {
  const MemoryScreen({Key? key}) : super(key: key);

  @override
  State<MemoryScreen> createState() => _MemoryScreenState();
}

class _MemoryScreenState extends State<MemoryScreen> with AutomaticKeepAliveClientMixin {
  bool _is_frame_buffer = false;
  double _vth_data_compression_ratio = 50;
  double _mobility_data_compression_ratio = 50;
  double _oled_data_compression_ratio = 50;
  double storage_video_compression_ratio = 50;

  final vthController = TextEditingController(text: "10");
  final mobilityController = TextEditingController(text: "6");
  final oledController = TextEditingController(text: "8");

  @override
  bool wantKeepAlive = true;

  @override
  void initState() {
    super.initState();
    context.read<Calculation>().bpsCalculate();
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
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Column(children: [
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Video Frame Buffer',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Text('compression\nratio(%)',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 17,
                              )),
                          Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              SfSlider(
                                value: storage_video_compression_ratio,
                                min: 0,
                                max: 80,
                                showTicks: true,
                                showLabels: true,
                                showDividers: true,
                                interval: 20,
                                stepSize: 1,
                                enableTooltip: true,
                                shouldAlwaysShowTooltip: true,
                                onChanged: (value) {
                                  setState(() {
                                    storage_video_compression_ratio = value;
                                    context.read<Calculation>().updateEach('storage_video_compression_ratio', value.toString());
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          Text(
                            'Storage',
                            style: const TextStyle(fontSize: 15),
                          ),
                          Text('${(context.watch<Calculation>().storage_video_result_mibits).toStringAsFixed(1)} Mbits',
                              textAlign: TextAlign.center, style: const TextStyle(fontSize: 17, color: Colors.blue)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    '${context.watch<Calculation>().ddr_frame_buffer.ceil()} ea of DDR Memory required \nwith ${(context.watch<Calculation>().margin_frame_buffer * 100).toStringAsFixed(2)}% of margin',
                    style: const TextStyle(fontSize: 20),
                  ),
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
                      SizedBox(
                        width: 30,
                      ),
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text('Total Storage',
                            style: const TextStyle(
                              fontSize: 15,
                            )),
                        Text('${(context.watch<Calculation>().storage_comp_result_mibits).toStringAsFixed(1)} Mbits',
                            textAlign: TextAlign.center, style: const TextStyle(fontSize: 17, color: Colors.blue)),
                      ])
                    ],
                  ),
                  SizedBox(
                    height: 40,
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
                            context.read<Calculation>().updateEach('vth_data_compression_ratio', value.toString());
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
                          controller: vthController,
                          onChanged: (value) {
                            if (value == '') {
                            } else {
                              context.read<Calculation>().updateEach('comp_vth_data_to_read', value);
                            }
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
                            context.read<Calculation>().updateEach('mobility_data_compression_ratio', value.toString());
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
                          controller: mobilityController,
                          onChanged: (value) {
                            if (value == '') {
                            } else
                              context.read<Calculation>().updateEach('comp_mobility_data_to_read', value);
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
                            context.read<Calculation>().updateEach('oled_data_compression_ratio', value.toString());
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
                          controller: oledController,
                          onChanged: (value) {
                            if (value == '') {
                            } else
                              context.read<Calculation>().updateEach('comp_oled_data_to_read', value);
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
                    '${context.watch<Calculation>().ddr_comp_data.ceil()} ea of DDR Memory required \nwith ${(context.watch<Calculation>().margin_comp_data * 100).toStringAsFixed(2)}% of margin',
                    style: const TextStyle(fontSize: 20),
                  ),
                ]),
              )),
        ));
  }
}
