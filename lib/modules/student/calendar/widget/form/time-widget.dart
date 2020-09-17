import 'package:flutter/material.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/formfield/decoration/builder.dart';
import 'package:universy/widgets/formfield/text/custom.dart';
import 'package:universy/widgets/formfield/text/validators.dart';
import 'package:universy/widgets/paddings/edge.dart';

class StudentEventTimeWidget extends FormField<TimeOfDay> {
  StudentEventTimeWidget({FormFieldSetter<TimeOfDay> onSaved,
    FormFieldValidator<TimeOfDay> validator,
    TimeOfDay initialValue,
    @required BuildContext context,
    String label,
    bool autovalidate = false})
      : super(
      onSaved: onSaved,
      validator: validator,
      initialValue: initialValue,
      autovalidate: autovalidate,
      builder: (FormFieldState<TimeOfDay> state) {
        return GestureDetector(
          onTap: () async {
            TimeOfDay selectedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
              builder: (BuildContext context, Widget child) {
                return MediaQuery(
                  data: MediaQuery.of(context)
                      .copyWith(alwaysUse24HourFormat: true),
                  child: child,
                );
              },
            );
            state.didChange(selectedTime);
          },
          child: SymmetricEdgePaddingWidget.vertical(
            paddingValue: 6.0,
            child: CustomTextFormField(
              enabled: false,
              controller: TextEditingController(text: state.value.format(context)),
              validatorBuilder: NotEmptyTextFormFieldValidatorBuilder(
                  AppText.getInstance().get(
                      "student.calendar.form.titleRequired")),
              decorationBuilder: TextInputDecorationBuilder('ASD'),
            ),
          ),
        );
      });
}

