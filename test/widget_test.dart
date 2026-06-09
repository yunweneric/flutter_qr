import 'package:flutter_qr/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Flutter QR app renders title', (tester) async {
    await tester.pumpWidget(const FlutterQrApp());
    await tester.pumpAndSettle();

    expect(find.text('Flutter QR'), findsOneWidget);
    expect(find.text('Export PNG'), findsOneWidget);
    expect(find.text('Preset'), findsOneWidget);
  });
}
