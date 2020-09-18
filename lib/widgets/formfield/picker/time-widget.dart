import 'package:flutter/material.dart';
import 'package:universy/widgets/formfield/decoration/builder.dart';
import 'package:universy/widgets/formfield/text/custom.dart';
import 'package:universy/widgets/formfield/text/validators.dart';
import 'package:universy/widgets/paddings/edge.dart';

class StudentEventTimeWidget extends FormField<TimeOfDay> {
  StudentEventTimeWidget(
      {@required BuildContext context,
      @required TextFormFieldValidatorBuilder validatorBuilder,
      @required FormFieldSetter<TimeOfDay> onSaved,
      @required TimeOfDay initialValue,
      FormFieldValidator<TimeOfDay> validator,
      String label = '',
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
                    controller: TextEditingController(
                        text: state.value.format(context)),
                    validatorBuilder: validatorBuilder,
                    decorationBuilder: TextInputDecorationBuilder(label),
                  ),
                ),
              );
            });
}
