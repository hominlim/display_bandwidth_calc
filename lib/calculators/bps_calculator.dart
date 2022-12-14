import 'package:flutter/material.dart';

class BpsCalc with ChangeNotifier {
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

  double _bps_calc_result_gibps = 0;
  double get bps_calc_result_gibps => _bps_calc_result_gibps;

  double _bps_calc_ddr = 0;
  double get bps_calc_ddr => _bps_calc_ddr;

  double _vertical_time = 0;
  double get vertical_time => _vertical_time;

  double _horizontal_time = 0;
  double get horizontal_time => _horizontal_time;

  double _horizontalTimeSliderValue = 10;
  double get horizontalTimeSliderValue => _horizontalTimeSliderValue;

  double _storage_video_compression_ratio = 50;
  double get storage_video_compression_ratio =>
      _storage_video_compression_ratio;

  double _video_data_to_read_write = 0;
  double get video_data_to_read_write => _video_data_to_read_write;

  double _storage_video_result_mibits = 0;
  double get storage_video_result_mibits => _storage_video_result_mibits;

  double _bw_frame_buffer = 0;
  double get bw_frame_buffer => _bw_frame_buffer;

  double _ddr_frame_buffer = 0;
  double get ddr_frame_buffer => _ddr_frame_buffer;

  double _vth_data_compression_ratio = 0;
  double get vth_data_compression_ratio => _vth_data_compression_ratio;

  double _mobility_data_compression_ratio = 0;
  double get mobility_data_compression_ratio =>
      _mobility_data_compression_ratio;

  double _oled_data_compression_ratio = 0;
  double get oled_data_compression_ratio => _oled_data_compression_ratio;

  double _margin_frame_buffer = 0;
  double get margin_frame_buffer => _margin_frame_buffer;

  double _comp_vth_data_to_read_total = 0;
  double _comp_vth_data_to_read = 0;
  double get comp_vth_data_to_read => _comp_vth_data_to_read;

  double _comp_mobility_data_to_read_total = 0;
  double _comp_mobility_data_to_read = 0;
  double get comp_mobility_data_to_read => _comp_mobility_data_to_read;

  double _comp_oled_data_to_read_total = 0;
  double _comp_oled_data_to_read = 0;
  double get comp_oled_data_to_read => _comp_oled_data_to_read;

  double _comp_data_to_read_total = 0;

  double _bw_comp_data = 0;

  double _ddr_comp_data = 0;
  double get ddr_comp_data => _ddr_comp_data;
  double _margin_comp_data = 0;
  double get margin_comp_data => _margin_comp_data;

  void columnUpdate(number_of_column) {
    _number_of_column = number_of_column;
    notifyListeners();
  }

  void rowUpdate(number_of_row) {
    _number_of_row = number_of_row;
    notifyListeners();
  }

  void fpsUpdate(frame_frequency) {
    _frame_frequency = frame_frequency;
    notifyListeners();
  }

  void dataWidthUpdata(data_width) {
    _data_width = data_width;
    notifyListeners();
  }

  void colorUpdate(number_of_color) {
    _number_of_color = number_of_color;
    notifyListeners();
  }

  void ddrSpeedUpdate(ddr_speed) {
    _ddr_speed = ddr_speed;
    notifyListeners();
  }

  void ddrWidthUpdate(ddr_width) {
    _ddr_width = ddr_width;
    notifyListeners();
  }

  void horizontalMarginUpdate(horizontalTimeSliderValue) {
    _horizontalTimeSliderValue = horizontalTimeSliderValue;
    notifyListeners();
  }

  void frameMemoryUpdate(storage_video_compression_ratio) {
    _storage_video_compression_ratio = storage_video_compression_ratio;
    _video_data_to_read_write = video_data_to_read_write;
    notifyListeners();
  }

  void vthDataUpdate(vth_data_compression_ratio, comp_vth_data_to_read) {
    _vth_data_compression_ratio = vth_data_compression_ratio;
    _comp_vth_data_to_read = comp_vth_data_to_read;
    notifyListeners();
  }

  void mobilityDataUpdate(
      mobility_data_compression_ratio, comp_mobility_data_to_read) {
    _mobility_data_compression_ratio = mobility_data_compression_ratio;
    _comp_mobility_data_to_read = comp_mobility_data_to_read;
    notifyListeners();
  }

  void oledDataUpdate(oled_data_compression_ratio, comp_oled_data_to_read) {
    _oled_data_compression_ratio = oled_data_compression_ratio;
    _comp_oled_data_to_read = comp_oled_data_to_read;
    notifyListeners();
  }

  void initDisplay(number_of_column, number_of_row, frame_frequency, data_width,
      number_of_color, ddr_speed, ddr_width) {
    _number_of_column = number_of_column;
    _number_of_row = number_of_row;
    _frame_frequency = frame_frequency;
    _data_width = data_width;
    _number_of_color = number_of_color;

    _ddr_speed = ddr_speed;
    _ddr_width = ddr_width;

    _bps_calc_result_gibps = number_of_column *
        number_of_row *
        frame_frequency *
        number_of_color *
        data_width /
        1024 /
        1024 /
        1024;

    _bps_calc_ddr = ddr_speed * ddr_width / 1024;

    _vertical_time = (1 / frame_frequency);
    _horizontal_time = (1 - _horizontalTimeSliderValue / 100) *
        _vertical_time /
        number_of_row *
        1000000;
  }

  void initDisplay2(storage_video_compression_ratio) {
    _storage_video_compression_ratio = storage_video_compression_ratio;
    _video_data_to_read_write = (1 - _storage_video_compression_ratio / 100) *
        number_of_column *
        // number_of_row *
        number_of_color *
        data_width *
        2;

    _storage_video_result_mibits =
        _video_data_to_read_write * number_of_row / 1024 / 1024;

    _bw_frame_buffer = _video_data_to_read_write / _horizontal_time / 1024;

    _ddr_frame_buffer = (_bw_frame_buffer / _bps_calc_ddr);
    _margin_frame_buffer =
        1 - _bw_frame_buffer / (_bps_calc_ddr * _ddr_frame_buffer.ceil());
  }

  void initDisplay3(
      vth_data_compression_ratio,
      comp_vth_data_to_read,
      mobility_data_compression_ratio,
      comp_mobility_data_to_read,
      oled_data_compression_ratio,
      comp_oled_data_to_read) {
    _vth_data_compression_ratio = vth_data_compression_ratio;
    _comp_vth_data_to_read = comp_vth_data_to_read;
    _mobility_data_compression_ratio = mobility_data_compression_ratio;
    _comp_mobility_data_to_read = comp_mobility_data_to_read;
    _oled_data_compression_ratio = oled_data_compression_ratio;
    _comp_oled_data_to_read = comp_oled_data_to_read;

    _comp_vth_data_to_read_total = (1 - _vth_data_compression_ratio / 100) *
        _number_of_column *
        _number_of_color *
        _comp_vth_data_to_read;

    _comp_mobility_data_to_read_total =
        (1 - _mobility_data_compression_ratio / 100) *
            _number_of_column *
            _number_of_color *
            _comp_mobility_data_to_read;

    _comp_oled_data_to_read_total = (1 - _oled_data_compression_ratio / 100) *
        _number_of_column *
        _number_of_color *
        _comp_oled_data_to_read;

    _comp_data_to_read_total = _comp_vth_data_to_read_total +
        _comp_mobility_data_to_read_total +
        _comp_oled_data_to_read_total;

    _bw_comp_data = _comp_data_to_read_total / _horizontal_time / 1024;
    _ddr_comp_data = _bw_comp_data / _bps_calc_ddr;
    _margin_comp_data =
        1 - _bw_comp_data / (_bps_calc_ddr * _ddr_comp_data.ceil());
  }

  void bpsCalculate() {
    _bps_calc_result_gibps = number_of_column *
        number_of_row *
        frame_frequency *
        number_of_color *
        data_width /
        1024 /
        1024 /
        1024;

    _bps_calc_ddr = ddr_speed * ddr_width / 1024;

    _vertical_time = (1 / frame_frequency);
    _horizontal_time = (1 - _horizontalTimeSliderValue / 100) *
        _vertical_time /
        number_of_row *
        1000000;

    notifyListeners();
  }

  void frameMemStorageCalc() {
    initDisplay2(storage_video_compression_ratio);

    notifyListeners();
  }
}
