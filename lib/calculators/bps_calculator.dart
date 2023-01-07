import 'package:display_bandwidth_calc/screens/tcon_input_screen.dart';
import 'package:flutter/material.dart';

class Calculation with ChangeNotifier {
  //#region for 사용자 입력
  // ----- Text Field of Main page ----`
  double _number_of_column = 3840;
  double _number_of_row = 2160;
  double _number_of_hblank = 560;
  double _number_of_vblank = 90;
  double _number_of_lane = 16;

  double _data_width = 10;
  double _number_of_color = 3;
  double _dclk_frequency = 74.25;

  double _ddr_speed = 1866;
  double _ddr_width = 16;

// ----- Slider of Main page----
  double _horizontal_time_margin = 5;
  double _storage_video_compression_ratio = 50;

// ----- Compensation data page, Slider and Textfield ----
  double _vth_data_compression_ratio = 50;
  double _comp_vth_data_to_read = 10;

  double _mobility_data_compression_ratio = 50;
  double _comp_mobility_data_to_read = 6;

  double _oled_data_compression_ratio = 50;
  double _comp_oled_data_to_read = 8;

//#endregion

// ----- Variables for Calculation ----
  double _number_of_column_total = 0;
  double _number_of_row_total = 0;
  double _freq_total = 0;

  double _fH = 0;
  double _fV = 0;
  double get fV => _fV;

  double _vertical_blank_time = 0;
  double get fVB => _vertical_blank_time;

  // double _bps_calc_result_gibps = 0;
  // double get bps_calc_result_gibps => _bps_calc_result_gibps;

  double _bps_calc_ddr = 0;
  double get bps_calc_ddr => _bps_calc_ddr;

  double _horizontal_time = 0;
  double get horizontal_time => _horizontal_time;

  double _video_data_to_read_write = 0;
  double _storage_video_result_mibits = 0;
  double get storage_video_result_mibits => _storage_video_result_mibits;

  double _bw_frame_buffer = 0;
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

  double _storage_comp_result_mibits = 0;
  double get storage_comp_result_mibits => _storage_comp_result_mibits;

  void updateEach(String varName, String varValueString) {
    double varValue = double.parse(varValueString);
    switch (varName) {
      case 'number_of_column':
        _number_of_column = varValue;
        break;
      case 'number_of_hblank':
        _number_of_hblank = varValue;
        break;
      case 'number_of_row':
        _number_of_row = varValue;
        break;
      case 'number_of_vblank':
        _number_of_vblank = varValue;
        break;
      case 'dclk_frequency':
        _dclk_frequency = varValue;
        break;
      case 'data_width':
        _data_width = varValue;
        break;
      case 'number_of_color':
        _number_of_color = varValue;
        break;
      case 'number_of_lane':
        _number_of_lane = varValue;
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

  void bpsCalculate() {
    // Total Clocks Calculation
    _number_of_column_total = _number_of_column + _number_of_hblank;
    _number_of_row_total = _number_of_row + _number_of_vblank;
    _freq_total = _dclk_frequency * _number_of_lane;

    _fH = _freq_total / _number_of_column_total;
    // print('${_fH * 1000} kHz');
    _fV = _fH / _number_of_row_total;
    // print('${_fV * 1000000} Hz');

    // Video Bandwidth
    // _bps_calc_result_gibps = _number_of_column_total * _number_of_row_total * _fV * _number_of_color * _data_width / 1024 / 1024 / 1024;

    // DDR Bandwidth
    _bps_calc_ddr = _ddr_speed * _ddr_width / 1024;

    // Horizontal time (1H time)
    _horizontal_time = (1 - _horizontal_time_margin / 100) / _fH;
    // print('$_horizontal_time us');

    // Vertical Blank time
    _vertical_blank_time = _number_of_vblank / _fH;
    // print('$_vertical_blank_time usec');

    // Video Frame Data One Line
    _video_data_to_read_write = (1 - _storage_video_compression_ratio / 100) * _number_of_column * _number_of_color * _data_width * 2;

    // Video Frame Data Storage
    _storage_video_result_mibits = _video_data_to_read_write * _number_of_row / 1024 / 1024;

    // ----------- Result Text  ------------
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
    // Total data per 1H
    _comp_data_to_read_total = _comp_vth_data_to_read_total + _comp_mobility_data_to_read_total + _comp_oled_data_to_read_total;

    //Storage data of 1 set
    _storage_comp_result_mibits = _comp_data_to_read_total * _number_of_row / 1024 / 1024;

    // ----------- Result comment Text ------------
    // Compensation memory Bandwidth required
    _bw_comp_data = _comp_data_to_read_total / _horizontal_time / 1024;

    // Number of DDR Memory
    _ddr_comp_data = _bw_comp_data / _bps_calc_ddr;

    // Margin of Frame buffer bandwidth
    _margin_comp_data = 1 - _bw_comp_data / (_bps_calc_ddr * _ddr_comp_data.ceil());

    // notifyListeners();
  }
}
