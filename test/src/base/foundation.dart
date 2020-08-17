import 'package:test/test.dart';
import 'package:mdc_dart/src/mdc-base/foundation.dart' show MDCFoundation;

// class FakeFoundation extends MDCFoundation {
//   get _adapter() {
//     return this.adapter;
//   }
// }

void testMDCFoundation() {
  group('MDCFoundation', () {
    // MDCFoundation foundation = MDCFoundation();
    // Component component;
    // Ripple ripple;

    test('cssClasses getter returns an empty object', () {
      final v = MDCFoundation.cssClasses;
      print(v);
      print(v.runtimeType);
      print(v.callMethod('valueOf'));
    });
  });
}
