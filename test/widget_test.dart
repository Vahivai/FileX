import 'package:flutter_test/flutter_test.dart';
import 'package:filex/app.dart';

void main() {
  testWidgets('FileX app loads successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const FileXApp());

    expect(find.text('FileX'), findsOneWidget);
  });
}