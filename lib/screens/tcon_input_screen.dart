import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:display_bandwidth_calc/calculators/bps_calculator.dart';
import 'package:intl/number_symbols_data.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:display_bandwidth_calc/calculators/model.dart';

class TconInputScreen extends StatefulWidget {
  const TconInputScreen({Key? key}) : super(key: key);

  @override
  State<TconInputScreen> createState() => _TconInputScreenState();
}

class _TconInputScreenState extends State<TconInputScreen> with AutomaticKeepAliveClientMixin {
  final columnController = TextEditingController(text: "3840");
  final hBlankController = TextEditingController(text: "560");
  final rowController = TextEditingController(text: "2160");
  final vBlankController = TextEditingController(text: "90");

  final colorController = TextEditingController(text: "3");
  final dataWidthController = TextEditingController(text: "10");
  // final fpsController = TextEditingController(text: "120");
  final dclkController = TextEditingController(text: "74.25");
  final laneController = TextEditingController(text: "16");

  final ddrSpeedController = TextEditingController(text: "1866");
  final ddrWidthController = TextEditingController(text: "16");

  double horizontal_time_margin = 5;
  double storage_video_compression_ratio = 50;

  List<String> dropdownList = ['1', '2', '3'];
  String selectDropdown = '1';

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
          margin: const EdgeInsets.only(left: 10, right: 30),
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              children: [
                DropdownButton<String>(
                    items: dropdownList.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        child: Text(value),
                        value: value,
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        selectDropdown = value!;
                      });
                    }),
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
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: "Column"),
                      controller: columnController,
                      onChanged: (value) {
                        if (value == '') {
                        } else {
                          context.read<Calculation>().updateEach('number_of_column', value);
                        }
                      },
                    )),
                    Expanded(
                        child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: "H-Blank"),
                      controller: hBlankController,
                      onChanged: (value) {
                        if (value == '') {
                        } else {
                          context.read<Calculation>().updateEach('number_of_hblank', value);
                        }
                      },
                    )),
                    Expanded(
                        child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: "Row"),
                      controller: rowController,
                      onChanged: (value) {
                        if (value == '') {
                        } else {
                          context.read<Calculation>().updateEach('number_of_row', value);
                        }
                      },
                    )),
                    Expanded(
                        child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: "V-Blank"),
                      controller: vBlankController,
                      onChanged: (value) {
                        if (value == '') {
                        } else {
                          context.read<Calculation>().updateEach('number_of_vblank', value);
                        }
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
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: "Input Lanes"),
                      controller: laneController,
                      onChanged: (value) {
                        if (value == '') {
                        } else {
                          context.read<Calculation>().updateEach('number_of_lane', value);
                        }
                      },
                    )),
                    Expanded(
                        child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: "Data Width"),
                      controller: dataWidthController,
                      onChanged: (value) {
                        if (value == '') {
                        } else {
                          context.read<Calculation>().updateEach('data_width', value);
                        }
                      },
                    )),
                    Expanded(
                        child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: "Colors"),
                      controller: colorController,
                      onChanged: (value) {
                        if (value == '') {
                        } else {
                          context.read<Calculation>().updateEach('number_of_color', value);
                        }
                      },
                    )),
                    Expanded(
                        child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: "DCLK(MHz)"),
                      controller: dclkController,
                      onChanged: (value) {
                        if (value == '') {
                        } else {
                          context.read<Calculation>().updateEach('dclk_frequency', value);
                        }
                      },
                    )),
                    Expanded(
                      child: Column(
                        children: [
                          Text('FPS',
                              style: const TextStyle(
                                fontSize: 15,
                              )),
                          Text('${NumberFormat('##.##').format(context.watch<Calculation>().fV)} Hz',
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('DDR Information',
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
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: "DDR (MT/s)"),
                      controller: ddrSpeedController,
                      onChanged: (value) {
                        if (value == '') {
                        } else {
                          context.read<Calculation>().updateEach('ddr_speed', value);
                        }
                      },
                    )),
                    Expanded(
                        child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: "Width by"),
                      controller: ddrWidthController,
                      onChanged: (value) {
                        if (value == '') {
                        } else {
                          context.read<Calculation>().updateEach('ddr_width', value);
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
                          Text('${NumberFormat('##.##').format(context.watch<Calculation>().bps_calc_ddr)} Gibps',
                              textAlign: TextAlign.center, style: const TextStyle(fontSize: 17, color: Colors.blue)),
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
                          value: horizontal_time_margin,
                          min: 0,
                          max: 10,
                          showTicks: true,
                          showLabels: true,
                          showDividers: true,
                          interval: 2,
                          stepSize: 0.5,
                          enableTooltip: true,
                          shouldAlwaysShowTooltip: true,
                          onChanged: (value) {
                            setState(() {
                              horizontal_time_margin = value;
                              context.read<Calculation>().updateEach('horizontal_time_margin', value.toString());
                            });
                          },
                        ),
                      ],
                    ),
                    Text(
                      '${NumberFormat('##.###').format(context.watch<Calculation>().horizontal_time)} us',
                      style: const TextStyle(fontSize: 20),
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
                        Text('Video Frame Buffer',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Text('compression\nratio(%)',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 17,
                            )),
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
                    Column(
                      children: [
                        Text(
                          'Storage',
                          style: const TextStyle(fontSize: 15),
                        ),
                        Text(
                          '${NumberFormat('##.##').format(context.watch<Calculation>().storage_video_result_mibits)} Mbits',
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
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
                  '${context.watch<Calculation>().ddr_frame_buffer.ceil()} ea of DDR Memory required \nwith ${(context.watch<Calculation>().margin_frame_buffer * 100).toStringAsFixed(2)}% of margin',
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
