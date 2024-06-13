
import 'package:flutter_test/flutter_test.dart';
import 'package:turathi/core/functions/get_user_city.dart';

void main() {
  group('Get User Place ', () {
    test('returns user location (City)', () async {
      String address = await UserCity(
          latitude: 32.33406902547508,
          longitude:
              35.750955583065895); //32.33406902547508, 35.750955583065895
      expect(address, "Ajlun");
    });
  });
}
