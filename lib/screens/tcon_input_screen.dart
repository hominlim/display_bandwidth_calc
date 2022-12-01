import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class TconInputScreen extends StatefulWidget {
  const TconInputScreen({Key? key}) : super(key: key);

  @override
  State<TconInputScreen> createState() => _TconInputScreenState();
}

class _TconInputScreenState extends State<TconInputScreen> {
// 폼의 상태를 얻기 위한 키
  final _columnController = TextEditingController(text: "3840");
  final _rowController = TextEditingController(text: "2160");
  final _fpsController = TextEditingController(text: "120");
  final _colorController = TextEditingController(text: "3");
  final _dataWidthController = TextEditingController(text: "10");
  final _ddrSpeedController = TextEditingController(text: "1866");
  final _ddrWidthController = TextEditingController(text: "16");

  double bps_calc_video = 0;
  double bps_calc_result_gibps = 0;
  double bps_calc_ddr = 0;
  double _resultDisplay = 0.00;

  double vertical_time = 0;
  double horizontal_time = 0;

  double storage_video_result_mbits = 0;
  double _horizontalTimeSliderValue = 10;
  double _storage_video_compression_ration = 50;

  @override
  void initState() {
    _bpsCalcResult();
    super.initState();
  }

  void _bpsCalcResult() {
    var number_of_column = double.parse(_columnController.text);
    var number_of_row = double.parse(_rowController.text);
    var frame_frequency = double.parse(_fpsController.text);
    var number_of_color = double.parse(_colorController.text);
    var data_width = double.parse(_dataWidthController.text);
    var ddr_speed = double.parse(_ddrSpeedController.text);
    var ddr_width = double.parse(_ddrWidthController.text);

    setState(() {
      bps_calc_video = number_of_column *
          number_of_row *
          frame_frequency *
          number_of_color *
          data_width;

      bps_calc_ddr = ddr_speed * ddr_width / 1024;

      vertical_time = (1 / frame_frequency);
      horizontal_time = (1 - _horizontalTimeSliderValue / 100) *
          vertical_time /
          number_of_row *
          1000000;

      bps_calc_result_gibps = bps_calc_video / 1024 / 1024 / 1024;

      storage_video_result_mbits =
          (1 - _storage_video_compression_ration / 100) *
              number_of_column *
              number_of_row *
              number_of_color *
              data_width /
              1024 /
              1024;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bandwidth Calculator'),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 10, right: 30),
        child: Column(
          children: [
            const SizedBox(
              height: 16.0,
            ),
            Text(
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
                  decoration: InputDecoration(labelText: "Column"),
                  controller: _columnController,
                )),
                Expanded(
                    child: TextField(
                  decoration: InputDecoration(labelText: "Row"),
                  controller: _rowController,
                )),
                Expanded(
                    child: TextField(
                  decoration: InputDecoration(labelText: "FPS"),
                  controller: _fpsController,
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
                  decoration: InputDecoration(labelText: "Data Width"),
                  controller: _dataWidthController,
                )),
                Expanded(
                    child: TextField(
                  decoration: InputDecoration(labelText: "Colors"),
                  controller: _colorController,
                )),
                Expanded(
                  child: Text(
                      '${NumberFormat('##.###').format(bps_calc_result_gibps)} Gibps',
                      textAlign: TextAlign.center,
                      style: TextStyle(
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
                  decoration: InputDecoration(labelText: "DDR speed"),
                  controller: _ddrSpeedController,
                )),
                Expanded(
                    child: TextField(
                  decoration: InputDecoration(labelText: "Width by"),
                  controller: _ddrWidthController,
                )),
                Expanded(
                  child: Text(
                      '${NumberFormat('##.###').format(bps_calc_ddr)} Gibps',
                      textAlign: TextAlign.center,
                      style: TextStyle(
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
                  onChanged: (dynamic value) {
                    setState(() {
                      _horizontalTimeSliderValue = value;
                      _bpsCalcResult();
                    });
                  },
                ),
                Text(
                  '${NumberFormat('##.###').format(horizontal_time)} us',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            const SizedBox(
              height: 50.0,
            ),
            Row(
              children: [
                SfSlider(
                  value: _storage_video_compression_ration,
                  min: 0,
                  max: 100,
                  showTicks: true,
                  showLabels: true,
                  showDividers: true,
                  interval: 25,
                  stepSize: 1,
                  enableTooltip: true,
                  shouldAlwaysShowTooltip: true,
                  onChanged: (dynamic value) {
                    setState(() {
                      _storage_video_compression_ration = value;
                      _bpsCalcResult();
                    });
                  },
                ),
                Text(
                  '${NumberFormat('##.###').format(storage_video_result_mbits)} Mbits',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
