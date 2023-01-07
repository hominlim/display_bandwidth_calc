import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:display_bandwidth_calc/calculators/bps_calculator.dart';
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
  final dclkController = TextEditingController(text: "74.25");
  final laneController = TextEditingController(text: "16");

  final ddrSpeedController = TextEditingController(text: "1866");
  final ddrWidthController = TextEditingController(text: "16");

  double horizontal_time_margin = 5;
  // double storage_video_compression_ratio = 50;

  List<String> modelName = ['Modified'];
  List<dynamic> modelInfo = [];
  // String selectDropdown = modelSelect;

  @override
  bool wantKeepAlive = true;

  void extractModelName(List<ModelInfo> model) {
    for (var i in model) {
      modelName.add(i.modelName);
    }
  }

  void findModel(List<ModelInfo> model, String modelSelect) {
    for (var i in model) {
      if (i.modelName == modelSelect) {
        modelInfo = i.returnAsList();
        // print(modelInfo);
        columnController.text = modelInfo[1].toStringAsFixed(0);
        hBlankController.text = modelInfo[2].toStringAsFixed(0);
        rowController.text = modelInfo[3].toStringAsFixed(0);
        vBlankController.text = modelInfo[4].toStringAsFixed(0);
        laneController.text = modelInfo[5].toStringAsFixed(0);
        dclkController.text = modelInfo[6].toStringAsFixed(2);
        dataWidthController.text = modelInfo[7].toStringAsFixed(0);
        colorController.text = modelInfo[8].toStringAsFixed(0);
        return;
      }
    }
  }

  void updataAll() {
    context.read<Calculation>().updateEach('number_of_column', columnController.text);
    context.read<Calculation>().updateEach('number_of_hblank', hBlankController.text);
    context.read<Calculation>().updateEach('number_of_row', rowController.text);
    context.read<Calculation>().updateEach('number_of_vblank', vBlankController.text);
    context.read<Calculation>().updateEach('number_of_lane', laneController.text);
    context.read<Calculation>().updateEach('dclk_frequency', dclkController.text);
    context.read<Calculation>().updateEach('data_width', dataWidthController.text);
    context.read<Calculation>().updateEach('number_of_color', colorController.text);
  }

  @override
  void initState() {
    super.initState();
    context.read<Calculation>().bpsCalculate();
    extractModelName(modelList);
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
                const SizedBox(
                  height: 15.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Input information',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(
                      width: 20,
                    ),
                    DropdownButton(
                        value: modelSelect,
                        items: modelName.map((String item) {
                          return DropdownMenuItem<String>(
                            child: Text('$item'),
                            value: item,
                          );
                        }).toList(),
                        onChanged: (dynamic value) {
                          setState(() {
                            modelSelect = value;
                            findModel(modelList, value!);
                            updataAll();
                          });
                        }),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: "Column"),
                      controller: columnController,
                      onChanged: (value) {
                        modelSelect = 'Modified';
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
                        modelSelect = 'Modified';
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
                        modelSelect = 'Modified';
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
                        modelSelect = 'Modified';
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: "Lanes"),
                      controller: laneController,
                      onChanged: (value) {
                        modelSelect = 'Modified';
                        if (value == '') {
                        } else {
                          context.read<Calculation>().updateEach('number_of_lane', value);
                        }
                      },
                    )),
                    Expanded(
                        child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: "DCLK"),
                      controller: dclkController,
                      onChanged: (value) {
                        modelSelect = 'Modified';
                        if (value == '') {
                        } else {
                          context.read<Calculation>().updateEach('dclk_frequency', value);
                        }
                      },
                    )),
                    Expanded(
                        child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: "Width"),
                      controller: dataWidthController,
                      onChanged: (value) {
                        modelSelect = 'Modified';
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
                        modelSelect = 'Modified';
                        if (value == '') {
                        } else {
                          context.read<Calculation>().updateEach('number_of_color', value);
                        }
                      },
                    )),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text('FPS',
                              style: const TextStyle(
                                fontSize: 15,
                              )),
                          Text('${(context.watch<Calculation>().fV * 1000000).toStringAsFixed(0)} Hz',
                              style: const TextStyle(
                                fontSize: 17,
                                color: Colors.blue,
                              )),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text('V-blank',
                              style: const TextStyle(
                                fontSize: 15,
                              )),
                          Text('${(context.watch<Calculation>().fVB).toStringAsFixed(0)} us',
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
                  height: 30.0,
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
                          Text('${(context.watch<Calculation>().bps_calc_ddr).toStringAsFixed(2)} Gibps', textAlign: TextAlign.center, style: const TextStyle(fontSize: 17, color: Colors.blue)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('One Horizontal time',
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
                    SizedBox(
                      width: 20,
                    ),
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('1H Time',
                          style: const TextStyle(
                            fontSize: 15,
                          )),
                      Text('${(context.watch<Calculation>().horizontal_time).toStringAsFixed(2)} us', textAlign: TextAlign.center, style: const TextStyle(fontSize: 17, color: Colors.blue)),
                    ])
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
