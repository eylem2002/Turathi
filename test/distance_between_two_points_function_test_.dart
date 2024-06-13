
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:turathi/core/functions/calculate_distanceInKm.dart';

void main() {
  test("distance between two points -equal- function", () {
    double distance = getDistanceInKm(
            lat1: 32.569333, lon1: 35.836211, lat2: 32.573104, lon2: 35.845838)
        .toPrecision(4);
    expect(distance, 0.9948);

  });

  test("distance between two points -boundaries- function 2", () {
    double distance = getDistanceInKm(
        lat1: -34.569663, lon1: 35.837697, lat2: -37.545333, lon2: 35.765453)
        .toPrecision(4);

    expect(distance, greaterThan(0));
    expect(distance, lessThan(20010));

  });

}
