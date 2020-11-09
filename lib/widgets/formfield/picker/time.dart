import 'package:flutter/material.dart';
import 'package:universy/util/object.dart';
import 'package:universy/widgets/paddings/edge.dart';

class StudentEventTimeWidget extends FormField<TimeOfDay> {
  StudentEventTimeWidget(
      {@required BuildContext context,
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
            String timeFormatted = state.value.format(context);
            return GestureDetector(
              behavior: HitTestBehavior.translucent,
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
                if (notNull(selectedTime)) {
                  state.didChange(selectedTime);
                }
              },
              child: SymmetricEdgePaddingWidget.vertical(
                paddingValue: 6.0,
                child: TextField(
                  enabled: false,
                  controller: TextEditingController(text: timeFormatted),
                  decoration: InputDecoration(labelText: label),
                ),
              ),
            );
          },
        );
}
