import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/model/student/schedule.dart';
import 'package:universy/modules/student/schedule/bloc/cubit.dart';
import 'package:universy/modules/student/schedule/widgets/scratch_buttons.dart';
import 'package:universy/util/object.dart';

class ScratchView extends StatefulWidget {
  final StudentScheduleScratch _scratch;
  final bool _create;

  const ScratchView(
      {Key key,
      @required StudentScheduleScratch scratch,
      @required bool create})
      : this._scratch = scratch,
        this._create = create,
        super(key: key);

  @override
  _ScratchViewState createState() => _ScratchViewState();
}

class _ScratchViewState extends State<ScratchView> {
  StudentScheduleScratch _scratch;
  ScheduleCubit _cubit;
  bool _create;

  @override
  void didChangeDependencies() {
    if (isNull(_cubit)) {
      this._cubit = BlocProvider.of<ScheduleCubit>(context);
    }
    super.didChangeDependencies();
  }

  @override
  void initState() {
    this._scratch = widget._scratch;
    this._create = widget._create;
    super.initState();
  }

  @override
  void dispose() {
    this._scratch = null;
    this._create = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            _buildScratchHeader(context),
            _buildScratchSchedule()
          ],
        ),
      ),
      floatingActionButton:
          _create ? ScheduleActionButton.create() : ScheduleActionButton.edit(),
    );
  }

  Widget _buildScratchSchedule() {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    return Container();
  }

  Widget _buildScratchHeader(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildHeaderTitles(),
        SizedBox(width: 15),
        _buildEditButton(),
      ],
    );
  }

  Widget _buildEditButton() {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () => {},
      color: Colors.amber,
    );
  }

  Widget _buildHeaderTitles() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 15),
        _buildPeriodTitle(context),
        SizedBox(height: 5),
        _buildPeriodSubtitle(context)
      ],
    );
  }

  Widget _buildPeriodTitle(BuildContext context) {
    return Text("Primer cuatrimestre",
        style: Theme.of(context).primaryTextTheme.headline3); //TODO: text
  }

  Widget _buildPeriodSubtitle(BuildContext context) {
    return Text("Enero 2020 - Diciembre 2020",
        style: Theme.of(context).primaryTextTheme.bodyText1); //TODO: text
  }
}
