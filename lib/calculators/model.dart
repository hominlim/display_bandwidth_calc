List modelList = [
  {"resolution": "FHD60", "activeH": 1920, "blankH": 280, "activeV": 1080, "blankV": 45, "lanes": 2, "freqPerLane": 74.25, "dataWidth": 10, "colors": 3},
  {"resolution": "FHD120", "activeH": 1920, "blankH": 280, "activeV": 1080, "blankV": 45, "lanes": 4, "freqPerLane": 74.25, "dataWidth": 10, "colors": 3},
  {"resolution": "4K60", "activeH": 3840, "blankH": 560, "activeV": 2160, "blankV": 90, "lanes": 8, "freqPerLane": 74.25, "dataWidth": 10, "colors": 3},
  {"resolution": "4K60", "activeH": 3840, "blankH": 560, "activeV": 2160, "blankV": 90, "lanes": 16, "freqPerLane": 74.25, "dataWidth": 10, "colors": 3},
  {"resolution": "4K60", "activeH": 3840, "blankH": 560, "activeV": 2160, "blankV": 90, "lanes": 16, "freqPerLane": 89.1, "dataWidth": 10, "colors": 3},
  {"resolution": "8K", "activeH": 7680, "blankH": 1320, "activeV": 4320, "blankV": 180, "lanes": 32, "freqPerLane": 74.25, "dataWidth": 10, "colors": 3},
  {"resolution": "8K", "activeH": 7680, "blankH": 1320, "activeV": 4320, "blankV": 180, "lanes": 64, "freqPerLane": 74.25, "dataWidth": 10, "colors": 3},
];

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

  @override
  String toString() {
    return 'Model Name : $modelName, column is $modelColumn, row is $modelRow';
  }
}
