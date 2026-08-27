import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mi_padre_hurtado/main.dart';

void main() {
  testWidgets('La app arranca en la pantalla de portada', (WidgetTester tester) async {
    await tester.pumpWidget(const MiPadreHurtadoApp());
    await tester.pumpAndSettle();

    // La app debe construir un MaterialApp sin lanzar excepciones.
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
