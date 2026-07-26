import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/core/widgets/custom_text_field.dart';

void main() {
  testWidgets(
    'CustomTextField input box does not shrink when a validation error appears',
    (tester) async {
      final formKey = GlobalKey<FormState>();
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: CustomTextField(
                controller: controller,
                hintText: 'Email',
                validator: (value) =>
                    (value == null || value.isEmpty) ? 'Required' : null,
              ),
            ),
          ),
        ),
      );

      // No RenderFlex/overflow errors on initial layout.
      expect(tester.takeException(), isNull);

      final editableHeightBefore = tester
          .getSize(find.byType(EditableText))
          .height;
      final totalHeightBefore = tester
          .getSize(find.byType(CustomTextField))
          .height;

      formKey.currentState!.validate();
      await tester.pump();

      // No layout errors once the error text is shown.
      expect(tester.takeException(), isNull);
      expect(find.text('Required'), findsOneWidget);

      final editableHeightAfter = tester
          .getSize(find.byType(EditableText))
          .height;
      final totalHeightAfter = tester
          .getSize(find.byType(CustomTextField))
          .height;

      // The actual text input area must stay exactly the same size.
      expect(editableHeightAfter, editableHeightBefore);
      // Only the overall widget (which now includes the error line below
      // the box) should grow.
      expect(totalHeightAfter, greaterThan(totalHeightBefore));
    },
  );
}
