import 'package:flutter/material.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/formfield/decoration/builder.dart';
import 'package:universy/widgets/formfield/text/custom.dart';
import 'package:universy/widgets/formfield/text/validators.dart';
import 'package:universy/widgets/paddings/edge.dart';

class StudentEventDateWidget extends FormField<DateTime> {
  StudentEventDateWidget(
      {FormFieldSetter<DateTime> onSaved,
      FormFieldValidator<DateTime> validator,
      @required DateTime initialValue,
      @required BuildContext context,
      String label,
      bool autovalidate = false})
      : super(
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            autovalidate: autovalidate,
            builder: (FormFieldState<DateTime> state) {
              return GestureDetector(
                onTap: () async {
                  DateTime selectedDate = await showDatePicker(
                    context: context,
                    initialDate: initialValue,
                    firstDate: DateTime(2015, 8),
                    lastDate: DateTime(2101),
                    builder: (BuildContext context, Widget child) {
                      return MediaQuery(
                        data: MediaQuery.of(context)
                            .copyWith(alwaysUse24HourFormat: true),
                        child: child,
                      );
                    },
                  );
                  state.didChange(selectedDate);
                },
                child: SymmetricEdgePaddingWidget.vertical(
                  paddingValue: 6.0,
                  child: CustomTextFormField(
                      enabled: false,
                      controller:
                          TextEditingController(text: state.value.toString()),
                      validatorBuilder: NotEmptyTextFormFieldValidatorBuilder(
                          AppText.getInstance()
                              .get("student.calendar.form.titleRequired")),
                      decorationBuilder: TextInputDecorationBuilder('ASD')),
                ),
              );
            });
}
