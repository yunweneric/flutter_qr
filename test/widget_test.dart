import 'package:flutter_qr/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Mini QR app renders title', (tester) async {
    await tester.pumpWidget(const MiniQrApp());
    await tester.pumpAndSettle();

    expect(find.text('Mini QR Code Generator'), findsOneWidget);
    expect(find.text('Download PNG'), findsOneWidget);
    expect(find.text('Data to encode'), findsOneWidget);
  });
}
