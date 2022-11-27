import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class TconInputScreen extends StatefulWidget {
  const TconInputScreen({Key? key}) : super(key: key);

  @override
  State<TconInputScreen> createState() => _TconInputScreenState();
}

class _TconInputScreenState extends State<TconInputScreen> {
  final _formKey = GlobalKey<FormState>(); // 폼의 상태를 얻기 위한 키
  final _columnController = TextEditingController(text: "3840");
  final _rowController = TextEditingController(text: "2160");
  final _fpsController = TextEditingController(text: "120");
  final _colorController = TextEditingController(text: "3");
  final _dataWidthController = TextEditingController(text: "10");
  final _ddrSpeedController = TextEditingController(text: "1866");
  final _ddrWidthController = TextEditingController(text: "16");

  var bps_calc_video = 0;
  var bps_calc_result_gibps = 0;
  var bps_calc_ddr = 0;
  var _resultDisplay = 0.00;

  String _resultDimmension = 'bps';
  String _resultString = '';
  String _resultVString = '';
  String _resultHString = '';

  double vertical_time = 0;
  double horizontal_time = 0;

  @override
  void initState() {
    super.initState();
  }

  void _bpsCalcResult(String bps) {
    var number_of_column = int.parse(_columnController.text);
    var number_of_row = int.parse(_rowController.text);
    var frame_frequency = int.parse(_fpsController.text);
    var number_of_color = int.parse(_colorController.text);
    var data_width = int.parse(_dataWidthController.text);
    var ddr_speed = int.parse(_ddrSpeedController.text);
    var ddr_width = int.parse(_ddrWidthController.text);

    bps_calc_video = number_of_column *
        number_of_row *
        frame_frequency *
        number_of_color *
        data_width;

    bps_calc_ddr = ddr_speed * ddr_width;

    vertical_time = (1 / frame_frequency);
    horizontal_time = vertical_time / number_of_row;

    bps_calc_result_gibps =
        (bps_calc_video.toDouble() / 1024 / 1024 / 1024) as int;

    _resultDimmension = bps;
    _resultString = NumberFormat('###,###,###,###.###').format(_resultDisplay);
    _resultVString = NumberFormat('###.###').format(vertical_time * 1000);
    _resultHString =
        NumberFormat('###.###').format(horizontal_time * 1000 * 1000);
    setState(() {});
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
                  child: Text('${bps_calc_result_gibps}, Gibps'),
                  // Text(
                  //   '$_resultString',
                  //   textAlign: TextAlign.center,
                  //   style: TextStyle(
                  //     fontSize: 25,
                  //   ),
                  // ),
                ),
              ],
            ),
            const Divider(
              height: 50,
              thickness: 1,
              indent: 20,
              endIndent: 0,
              color: Colors.black45,
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
                  child: Text('${bps_calc_result_gibps}, Gibps'),
                ),
              ],
            ),
            const SizedBox(
              height: 16.0,
            ),
            Row(
              children: [
                Slider(
                  value: 20,
                  max: 100,
                  divisions: 5,
                  label: '20',
                  onChanged: (double value) {
                    setState(() {});
                  },
                ),
                Text(
                  '1H : $_resultHString us',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            Row(
              children: [
                Slider(
                  value: 20,
                  max: 100,
                  divisions: 5,
                  label: '20',
                  onChanged: (double value) {
                    setState(() {});
                  },
                ),
                Text(
                  'xxx Mibits',
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
