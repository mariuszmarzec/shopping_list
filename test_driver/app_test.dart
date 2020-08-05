// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Test', () {

    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('Add new product', () async {
      await driver.tap(find.byType("FloatingActionButton"));
      await driver.tap(find.byValueKey("productName"));
      await driver.enterText("product");
      await driver.tap(find.byType("RaisedButton"));
      await expect(find.text("product"), isNotNull);

    });
  });
}
