// This is a basic Flutter widget test.
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:devlearning_indo/main.dart';

void main() {
  testWidgets('email wajib mengandung tanda @', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'Budi');
    await tester.enterText(fields.at(1), 'budi.example.com');
    await tester.enterText(fields.at(3), 'Bandung');
    await tester.tap(find.text('Daftar'));
    await tester.pump();

    expect(find.text('Format email tidak valid'), findsOneWidget);
  });

  testWidgets('pendaftaran menampilkan dialog dan konfirmasi', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'Budi');
    await tester.enterText(fields.at(1), 'budi@example.com');
    await tester.enterText(fields.at(3), 'Bandung');
    await tester.tap(find.text('Daftar'));
    await tester.pumpAndSettle();

    expect(find.text('Ringkasan Pendaftaran'), findsOneWidget);
    expect(find.text('Nama: Budi'), findsOneWidget);

    await tester.tap(find.text('Lanjut'));
    await tester.pumpAndSettle();

    expect(
      find.text('Terima kasih, Budi dari Bandung telah mendaftar.'),
      findsOneWidget,
    );
  });
}

