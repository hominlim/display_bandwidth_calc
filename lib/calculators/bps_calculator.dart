import 'package:display_bandwidth_calc/screens/tcon_input_screen.dart';
import 'package:flutter/material.dart';

class Calculation with ChangeNotifier {
  //#region for 사용자 입력
  double _number_of_column = 0;
  double get number_of_column => _number_of_column;

  double _number_of_row = 0;
  double get number_of_row => _number_of_row;

  double _frame_frequency = 0;
  double get frame_frequency => _frame_frequency;

  double _data_width = 0;
  double get data_width => _data_width;

  double _number_of_color = 0;
  double get number_of_color => _number_of_color;

  double _ddr_speed = 0;
  double get ddr_speed => _ddr_speed;

  double _ddr_width = 0;
  double get ddr_width => _ddr_width;

  double _horizontal_time_margin = 0;
  double get horizontal_time_margin => _horizontal_time_margin;

  double _storage_video_compression_ratio = 0;
  double get storage_video_compression_ratio => _storage_video_compression_ratio;

  double _vth_data_compression_ratio = 0;
  double get vth_data_compression_ratio => _vth_data_compression_ratio;

  double _comp_vth_data_to_read = 0;
  double get comp_vth_data_to_read => _comp_vth_data_to_read;

  double _mobility_data_compression_ratio = 0;
  double get mobility_data_compression_ratio => _mobility_data_compression_ratio;

  double _comp_mobility_data_to_read = 0;
  double get comp_mobility_data_to_read => _comp_mobility_data_to_read;

  double _oled_data_compression_ratio = 0;
  double get oled_data_compression_ratio => _oled_data_compression_ratio;

  double _comp_oled_data_to_read = 0;
  double get comp_oled_data_to_read => _comp_oled_data_to_read;

//#endregion

  double _bps_calc_result_gibps = 0;
  double get bps_calc_result_gibps => _bps_calc_result_gibps;

  double _bps_calc_ddr = 0;
  double get bps_calc_ddr => _bps_calc_ddr;

  double _vertical_time = 0;
  double get vertical_time => _vertical_time;

  double _horizontal_time = 0;
  double get horizontal_time => _horizontal_time;

  double _video_data_to_read_write = 0;
  double get video_data_to_read_write => _video_data_to_read_write;

  double _storage_video_result_mibits = 0;
  double get storage_video_result_mibits => _storage_video_result_mibits;

  double _bw_frame_buffer = 0;
  double get bw_frame_buffer => _bw_frame_buffer;

  double _ddr_frame_buffer = 0;
  double get ddr_frame_buffer => _ddr_frame_buffer;

  double _margin_frame_buffer = 0;
  double get margin_frame_buffer => _margin_frame_buffer;

  double _comp_vth_data_to_read_total = 0;
  double _comp_mobility_data_to_read_total = 0;
  double _comp_oled_data_to_read_total = 0;
  double _comp_data_to_read_total = 0;

  double _bw_comp_data = 0;

  double _ddr_comp_data = 0;
  double get ddr_comp_data => _ddr_comp_data;
  double _margin_comp_data = 0;
  double get margin_comp_data => _margin_comp_data;

  void updateEach(String varName, String varValueString) {
    double varValue = double.parse(varValueString);
    switch (varName) {
      case 'number_of_column':
        _number_of_column = varValue;
        print(_number_of_column);
        break;
      case 'number_of_row':
        _number_of_row = varValue;
        break;
      case 'frame_frequency':
        _frame_frequency = varValue;
        break;
      case 'data_width':
        _data_width = varValue;
        break;
      case 'number_of_color':
        _number_of_color = varValue;
        break;
      case 'ddr_speed':
        _ddr_speed = varValue;
        break;
      case 'ddr_width':
        _ddr_width = varValue;
        break;
      case 'horizontal_time_margin':
        _horizontal_time_margin = varValue;
        break;
      case 'storage_video_compression_ratio':
        _storage_video_compression_ratio = varValue;
        // _video_data_to_read_write = video_data_to_read_write;
        break;
      case 'vth_data_compression_ratio':
        _vth_data_compression_ratio = varValue;
        break;
      case 'comp_vth_data_to_read':
        _comp_vth_data_to_read = varValue;
        break;
      case 'mobility_data_compression_ratio':
        _mobility_data_compression_ratio = varValue;
        break;
      case 'comp_mobility_data_to_read':
        _comp_mobility_data_to_read = varValue;
        break;
      case 'oled_data_compression_ratio':
        _oled_data_compression_ratio = varValue;
        break;
      case 'comp_oled_data_to_read':
        _comp_oled_data_to_read = varValue;
        break;

      default:
        break;
    }
    bpsCalculate();
    notifyListeners();
  }

//#region initDisplay 1, 2, 3

  void initDisplay(number_of_column, number_of_row, frame_frequency, data_width, number_of_color, ddr_speed, ddr_width, horizontal_time_margin, storage_video_compression_ratio) {
    _number_of_column = double.parse(number_of_column);
    _number_of_row = double.parse(number_of_row);
    _frame_frequency = double.parse(frame_frequency);
    _data_width = double.parse(data_width);
    _number_of_color = double.parse(number_of_color);
    _ddr_speed = double.parse(ddr_speed);
    _ddr_width = double.parse(ddr_width);
    _horizontal_time_margin = horizontal_time_margin;
    _storage_video_compression_ratio = storage_video_compression_ratio;

    bpsCalculate();
  }

  void initDisplay3(vth_data_compression_ratio, comp_vth_data_to_read, mobility_data_compression_ratio, comp_mobility_data_to_read, oled_data_compression_ratio, comp_oled_data_to_read) {
    _vth_data_compression_ratio = vth_data_compression_ratio;
    _comp_vth_data_to_read = double.parse(comp_vth_data_to_read);
    _mobility_data_compression_ratio = mobility_data_compression_ratio;
    _comp_mobility_data_to_read = double.parse(comp_mobility_data_to_read);
    _oled_data_compression_ratio = oled_data_compression_ratio;
    _comp_oled_data_to_read = double.parse(comp_oled_data_to_read);

    bpsCalculate();
  }
//#endregion

  void bpsCalculate() {
    // Video Bandwidth
    _bps_calc_result_gibps = _number_of_column * _number_of_row * _frame_frequency * _number_of_color * _data_width / 1024 / 1024 / 1024;

    // DDR Bandwidth
    _bps_calc_ddr = _ddr_speed * _ddr_width / 1024;

    // Vertical time
    _vertical_time = (1 / _frame_frequency);

    // Horizontal time
    _horizontal_time = (1 - _horizontal_time_margin / 100) * _vertical_time / _number_of_row * 1000000;

    // Video Frame Data One Line
    _video_data_to_read_write = (1 - _storage_video_compression_ratio / 100) * _number_of_column * _number_of_color * _data_width * 2;

    // Video Frame Data Storage
    _storage_video_result_mibits = _video_data_to_read_write * _number_of_row / 1024 / 1024;

    // ----------- Result Text ------------
    // Frame memory Bandwidth required
    _bw_frame_buffer = _video_data_to_read_write / _horizontal_time / 1024;
    // Number of DDR memory
    _ddr_frame_buffer = (_bw_frame_buffer / _bps_calc_ddr);
    // Margin of Frame buffer bandwidth
    _margin_frame_buffer = 1 - _bw_frame_buffer / (_bps_calc_ddr * _ddr_frame_buffer.ceil());

    // Vth data
    _comp_vth_data_to_read_total = (1 - _vth_data_compression_ratio / 100) * _number_of_column * _number_of_color * _comp_vth_data_to_read;
    // Mobility data
    _comp_mobility_data_to_read_total = (1 - _mobility_data_compression_ratio / 100) * _number_of_column * _number_of_color * _comp_mobility_data_to_read;
    // OLED data
    _comp_oled_data_to_read_total = (1 - _oled_data_compression_ratio / 100) * _number_of_column * _number_of_color * _comp_oled_data_to_read;
    // Total data
    _comp_data_to_read_total = _comp_vth_data_to_read_total + _comp_mobility_data_to_read_total + _comp_oled_data_to_read_total;

    // ----------- Result Text ------------
    // Compensation memory Bandwidth required
    _bw_comp_data = _comp_data_to_read_total / _horizontal_time / 1024;
    // Number of DDR Memory
    _ddr_comp_data = _bw_comp_data / _bps_calc_ddr;
    // Margin of Frame buffer bandwidth
    _margin_comp_data = 1 - _bw_comp_data / (_bps_calc_ddr * _ddr_comp_data.ceil());

    // notifyListeners();
  }
}
