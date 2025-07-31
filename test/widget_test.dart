import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:leicht_erlernen/main.dart';

void main() {
  testWidgets('PDF viewer smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const TestPdfApp());

    expect(find.text('PDF Test - Lektion 1'), findsOneWidget);
  });
} 