import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/modules/student/schedule/bloc/cubit.dart';
import 'package:universy/modules/student/schedule/dialogs/scratch_form.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/buttons/outlined/custom_icon.dart';

class AddScratchButton extends StatelessWidget {
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CustomOutlinedButtonIcon(
        iconData: Icons.add,
        onPressed: () => _openNewScratch(context),
        labelText: AppText.getInstance().get("student.schedule.addNewSchedule"),
        buttonTextStyle: Theme.of(context).textTheme.button,
        color: Theme.of(context).buttonColor,
      ),
    );
  }

  void _openNewScratch(BuildContext context) {
    ScheduleCubit cubit = BlocProvider.of<ScheduleCubit>(context);
    showDialog(
      context: context,
      builder: (dialogContext) => ScratchFormDialog(cubit: cubit, create: true),
    );
  }
}
