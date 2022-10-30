import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class MemoryScreen extends StatefulWidget {
  const MemoryScreen({Key? key}) : super(key: key);

  @override
  State<MemoryScreen> createState() => _MemoryScreenState();
}

class _MemoryScreenState extends State<MemoryScreen> {
  final _formKey = GlobalKey<FormState>(); // 폼의 상태를 얻기 위한 키
  final _frequencyController = TextEditingController(text: "933");
  final _datawidthController = TextEditingController(text: "16");
  final _numberOfmemoryController = TextEditingController(text: "4");

  var _result = 0;

  String _resultString = '';

  String _resulMTsString = '';

  @override
  void initState() {
    super.initState();
  }

  void _calcResult() {
    var nMTs = int.parse(_frequencyController.text) * 2;
    var ndataWidth = int.parse(_datawidthController.text);
    var nNumberOfMemory = int.parse(_numberOfmemoryController.text);

    _result = nMTs * ndataWidth * nNumberOfMemory; // temporal number for test
    _resultString =
        NumberFormat('###,###,###,###.###').format(_result.toDouble());

    _resulMTsString = NumberFormat('###.###').format(nMTs);
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
                  'DDR Memory',
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Please Enter Clock Frequency',
                    labelText: 'Memory Clock (MHz)',
                    icon: Icon(Icons.display_settings),
                  ),
                  keyboardType: TextInputType.number, // 숫자만 입력
                  controller: _frequencyController,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      //입력한 값의 앞뒤 공백을 제거한 것이 비었다면 에러 메시지 표시
                      return 'Enter column';
                    }
                    return null;
                  },
                  onChanged: ((value) => _calcResult()),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Please Enter Data Width',
                    labelText: 'Data Width (bits)',
                    icon: Icon(Icons.display_settings),
                  ),
                  keyboardType: TextInputType.number, // 숫자만 입력
                  controller: _datawidthController,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      //입력한 값의 앞뒤 공백을 제거한 것이 비었다면 에러 메시지 표시
                      return 'Enter column';
                    }
                    return null;
                  },
                  onChanged: ((value) => _calcResult()),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Please Enter Number of parts',
                    labelText: 'Number of memory (ea)',
                    icon: Icon(Icons.display_settings),
                  ),
                  keyboardType: TextInputType.number, // 숫자만 입력
                  controller: _numberOfmemoryController,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      //입력한 값의 앞뒤 공백을 제거한 것이 비었다면 에러 메시지 표시
                      return 'Enter column';
                    }
                    return null;
                  },
                  onChanged: ((value) => _calcResult()),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Text('$_resulMTsString MT/s'),
                Container(
                  margin: const EdgeInsets.only(top: 16.0),
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    // 폼에 입력된 값 검증
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _calcResult();
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
