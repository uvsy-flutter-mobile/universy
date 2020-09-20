import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:universy/widgets/formfield/decoration/builder.dart';
import 'package:universy/widgets/formfield/text/custom.dart';
import 'package:universy/widgets/formfield/text/validators.dart';
import 'package:universy/widgets/paddings/edge.dart';

class StudentEventDateWidget extends FormField<DateTime> {
  StudentEventDateWidget(
      {@required BuildContext context,
      @required TextFormFieldValidatorBuilder validatorBuilder,
      @required FormFieldSetter<DateTime> onSaved,
      @required DateTime initialValue,
      FormFieldValidator<DateTime> validator,
      String label = '',
      int yearFrom = 2015,
      int yearTo = 2100,
      bool autovalidate = false})
      : super(
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            autovalidate: autovalidate,
            builder: (FormFieldState<DateTime> state) {
              DateFormat formatter = DateFormat('dd-MM-yyyy');
              String dateFormatted = formatter.format(state.value);
              return GestureDetector(
                onTap: () async {
                  DateTime selectedDate = await showDatePicker(
                    context: context,
                    initialDate: initialValue,
                    firstDate: DateTime(yearFrom),
                    lastDate: DateTime(yearTo),
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
                      controller: TextEditingController(text: dateFormatted),
                      validatorBuilder: validatorBuilder,
                      decorationBuilder: TextInputDecorationBuilder(label)),
                ),
              );
            });
}
