import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class SystemLinkScreen extends StatefulWidget {
  const SystemLinkScreen({Key? key}) : super(key: key);

  @override
  State<SystemLinkScreen> createState() => _SystemLinkScreenState();
}

class _SystemLinkScreenState extends State<SystemLinkScreen> {
  final _formKey = GlobalKey<FormState>(); // 폼의 상태를 얻기 위한 키
  final _columnController = TextEditingController(text: "3840");
  final _rowController = TextEditingController(text: "2160");
  final _fpsController = TextEditingController(text: "120");
  final _colorController = TextEditingController(text: "3");
  final _datawidthController = TextEditingController(text: "10");

  var _result = 0;
  var _resultDisplay = 0.00;

  String _resultDimmension = 'bps';
  String _resultString = '';
  String _resultVString = '';
  String _resultHString = '';

  double _OneVTime = 0;
  double _OneHTime = 0;

  @override
  void initState() {
    super.initState();
  }

  void _calcResult(String bps) {
    var nColumn = int.parse(_columnController.text);
    var nRow = int.parse(_rowController.text);
    var nFrameRate = int.parse(_fpsController.text);
    var nColor = int.parse(_colorController.text);
    var nDataWidth = int.parse(_datawidthController.text);

    _result = nColumn * nRow * nFrameRate * nColor * nDataWidth;
    _OneVTime = (1 / nFrameRate);
    _OneHTime = _OneVTime / nRow;

    if (bps == 'bps') {
      _resultDisplay = _result.toDouble();
      _resultDimmension = 'bps';
    } else if (bps == 'Mibps') {
      _resultDisplay = _result.toDouble() / 1024 / 1024;
      _resultDimmension = 'Mibps';
    } else if (bps == 'Gibps') {
      _resultDisplay = _result.toDouble() / 1024 / 1024 / 1024;
      _resultDimmension = 'Gibps';
    }
    _resultDimmension = bps;
    _resultString = NumberFormat('###,###,###,###.###').format(_resultDisplay);
    _resultVString = NumberFormat('###.###').format(_OneVTime * 1000);
    _resultHString = NumberFormat('###.###').format(_OneHTime * 1000 * 1000);
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
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                  'System Link',
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        _columnController.text = '1920';
                        _rowController.text = '1080';
                        _calcResult(_resultDimmension);
                      },
                      icon: Icon(
                        Icons.two_k_outlined,
                        size: 30,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _columnController.text = '3840';
                        _rowController.text = '2160';
                        _calcResult(_resultDimmension);
                      },
                      icon: Icon(
                        Icons.four_k_outlined,
                        size: 30,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _columnController.text = '7680';
                        _rowController.text = '4320';
                        _calcResult(_resultDimmension);
                      },
                      icon: Icon(
                        Icons.eight_k_outlined,
                        size: 30,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (_fpsController.text == '60') {
                            _fpsController.text = '120';
                          } else
                            _fpsController.text = '60';
                          _calcResult(_resultDimmension);
                        });
                      },
                      icon: Icon(
                        Icons.sixty_fps_select_sharp,
                        size: 30,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(
                          () {
                            if (_colorController.text == '3') {
                              _colorController.text = '4';
                            } else
                              _colorController.text = '3';
                            _calcResult(_resultDimmension);
                          },
                        );
                      },
                      icon: Icon(
                        Icons.color_lens_outlined,
                        size: 30,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(
                          () {
                            if (int.parse(_datawidthController.text) <= 7 ||
                                (int.parse(_datawidthController.text) >= 12)) {
                              _datawidthController.text = '8';
                            } else {
                              _datawidthController.text =
                                  (int.parse(_datawidthController.text) + 1)
                                      .toString();
                            }
                            _calcResult(_resultDimmension);
                          },
                        );
                      },
                      icon: Icon(
                        Icons.data_object_sharp,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Please Enter Column',
                    labelText: 'Column',
                    icon: Icon(Icons.display_settings),
                  ),
                  // initialValue: '3840',
                  keyboardType: TextInputType.number, // 숫자만 입력
                  controller: _columnController,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      //입력한 값의 앞뒤 공백을 제거한 것이 비었다면 에러 메시지 표시
                      return 'Enter column';
                    }
                    return null;
                  },
                  // onChanged: (text) {
                  //   setState(() {
                  //     print('Column is changed to $text');
                  //   });
                  // },
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Please Enter Row',
                    labelText: 'Row',
                    icon: Icon(Icons.swap_vertical_circle_outlined),
                  ),
                  keyboardType: TextInputType.number, // 숫자만 입력

                  controller: _rowController,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      //입력한 값의 앞뒤 공백을 제거한 것이 비었다면 에러 메시지 표시
                      return 'Enter row';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Please Enter Frame Rate',
                    labelText: 'FPS',
                    icon: Icon(Icons.speed),
                  ),
                  keyboardType: TextInputType.number, // 숫자만 입력
                  controller: _fpsController,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      //입력한 값의 앞뒤 공백을 제거한 것이 비었다면 에러 메시지 표시
                      return 'Enter FPS';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Please Enter Number of Colors',
                    labelText: 'Colors',
                    icon: Icon(Icons.color_lens_outlined),
                  ),
                  keyboardType: TextInputType.number, // 숫자만 입력
                  controller: _colorController,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      //입력한 값의 앞뒤 공백을 제거한 것이 비었다면 에러 메시지 표시
                      return 'Enter Number of Colors';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Please Enter Data width per Color',
                    labelText: 'Data Width per Color',
                    icon: Icon(Icons.data_object_sharp),
                  ),
                  keyboardType: TextInputType.number, // 숫자만 입력
                  controller: _datawidthController,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      //입력한 값의 앞뒤 공백을 제거한 것이 비었다면 에러 메시지 표시
                      return 'Enter Data bit width';
                    }
                    return null;
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16.0),
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    // 폼에 입력된 값 검증
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _calcResult(_resultDimmension);
                        });
                      }
                    },

                    child: const Text('Calculate'),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$_resultString',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          if (_resultDimmension == 'bps') {
                            _calcResult('Mibps');
                          } else if (_resultDimmension == 'Mibps') {
                            _calcResult('Gibps');
                          } else if (_resultDimmension == 'Gibps') {
                            _calcResult('bps');
                          }
                        },
                        child: Text(
                          '$_resultDimmension',
                        ),
                        style: TextButton.styleFrom(
                            primary: Colors.deepPurple,
                            padding: EdgeInsets.all(10),
                            textStyle: TextStyle(
                              fontSize: 30,
                              color: Colors.yellow,
                            )),
                      ),
                      ElevatedButton(
                        // 폼에 입력된 값 검증
                        onPressed: () {
                          // 메모리카피
                          Clipboard.setData(ClipboardData(text: '$_result'));
                        },
                        child: const Text('Copy'),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.deepPurple,
                            padding: EdgeInsets.all(3),
                            textStyle: TextStyle(
                              fontSize: 15,
                              color: Colors.yellow,
                            )),
                      ),
                    ],
                  ),
                ),
                Text(
                  '1V : $_resultVString ms',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  '1H : $_resultHString us',
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
