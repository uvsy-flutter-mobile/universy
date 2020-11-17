import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:universy/util/object.dart';
import 'package:universy/widgets/paddings/edge.dart';

class MonthPickerWidget extends FormField<DateTime> {
  MonthPickerWidget(
      {@required BuildContext context,
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
              DateFormat formatter = DateFormat('MMM yyyy');
              String dateFormatted = formatter.format(state.value);
              return GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () async {
                  DateTime selectedDate = await showMonthPicker(
                    context: context,
                    initialDate: initialValue,
                    firstDate: DateTime(yearFrom),
                    lastDate: DateTime(yearTo),
                  );
                  if (notNull(selectedDate)) {
                    state.didChange(selectedDate);
                  }
                },
                child: SymmetricEdgePaddingWidget.vertical(
                  paddingValue: 6.0,
                  child: TextField(
                      enabled: false,
                      controller: TextEditingController(text: dateFormatted),
                      decoration: InputDecoration(labelText: label)),
                ),
              );
            });
}
