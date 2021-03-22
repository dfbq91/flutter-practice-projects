import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:meta/meta.dart';

class ScanModel {
  ScanModel({
    this.id,
    this.type,
    @required this.value,
  }) {
    if (this.value.contains('http')) {
      this.type = 'http';
    } else {
      this.type = 'geo';
    }
  }

  int id;
  String type;
  String value;

  LatLng getLtnLng() {
    final ltnLng = value.substring(4).split(',');
    final latitude = double.parse(ltnLng[0]);
    final longitude = double.parse(ltnLng[1]);
    return LatLng(latitude, longitude);
  }

  factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        type: json["type"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "value": value,
      };
}
