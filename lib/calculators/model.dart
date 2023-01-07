class ModelInfo {
  String modelName = "";
  double activeH = 0;
  double blankH = 0;
  double activeV = 0;
  double blankV = 0;
  double lanes = 0;
  double freqPerLane = 0;
  double dataWidth = 0;
  double colors = 0;

  ModelInfo(this.modelName, this.activeH, this.blankH, this.activeV, this.blankV, this.lanes, this.freqPerLane, this.dataWidth, this.colors);

  List<dynamic> returnAsList() {
    return [modelName, activeH, blankH, activeV, blankV, lanes, freqPerLane, dataWidth, colors];
  }
}

final modelList = [
  ModelInfo('FHD60', 1920, 280, 1080, 45, 2, 74.25, 10, 3),
  ModelInfo('FHD120', 1920, 280, 1080, 45, 4, 74.25, 10, 3),
  ModelInfo('4K60', 3840, 560, 2160, 90, 8, 74.25, 10, 3),
  ModelInfo('4K120', 3840, 560, 2160, 90, 16, 74.25, 10, 3),
  ModelInfo('4K144', 3840, 560, 2160, 90, 16, 89.10, 10, 3),
  ModelInfo('8K60', 7680, 1320, 4320, 80, 32, 74.25, 10, 3),
  ModelInfo('8K120', 7680, 1120, 4320, 180, 64, 74.25, 10, 3),
];
var modelSelect = '4K120';
