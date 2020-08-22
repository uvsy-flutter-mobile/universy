import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universy/constants/routes.dart';
import 'package:universy/model/institution/queries.dart';
import 'package:universy/services/factory.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/dialog/confirm.dart';

class MainDrawerHeader extends StatelessWidget {
  final InstitutionProgramInfo currentProgram;
  final List<InstitutionProgramInfo> otherPrograms;

  const MainDrawerHeader({Key key, this.currentProgram, this.otherPrograms})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orangeAccent,
      child: _buildUserAccountHeader(context),
    );
  }

  Widget _buildUserAccountHeader(BuildContext context) {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(color: Colors.orangeAccent),
      accountName: _buildCareerName(),
      accountEmail: _buildInstitutionName(),
      currentAccountPicture: _buildCareerCodename(),
      otherAccountsPictures: _buildOtherPrograms(context),
    );
  }

  List<Widget> _buildOtherPrograms(BuildContext context) {
    var programWidgets =
        otherPrograms.map((p) => _buildCareerWidget(context, p)).toList();
    if (programWidgets.length <= 2) {
      Widget addWidget = _buildAddCareerWidget(context);
      programWidgets.add(addWidget);
    }
    return programWidgets;
  }

  Widget _buildCareerWidget(
      BuildContext context, InstitutionProgramInfo programInfo) {
    return GestureDetector(
      onTap: () => _handleProgramChange(context, programInfo),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        child: Text(
          programInfo.career.codename,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  void _handleProgramChange(
      BuildContext context, InstitutionProgramInfo programInfo) async {
    String switchCareer =
        AppText.getInstance().get("main.drawer.career.actions.switchCareer");
    bool changeCareer = await showDialog(
          context: context,
          builder: (context) => ConfirmDialog(
            title: "",
            content: "$switchCareer ${programInfo.career.name}",
          ),
        ) ??
        false;

    if (changeCareer) {
      await Provider.of<ServiceFactory>(context, listen: false)
          .studentCareerService()
          .setCurrentProgram(programInfo.programId);
      Navigator.pop(context);
      await Navigator.pushReplacementNamed(context, Routes.HOME);
    }
  }

  Widget _buildAddCareerWidget(BuildContext context) {
    return GestureDetector(
      onTap: () => _handleAddCareer(context),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.add,
          color: Theme.of(context).accentColor,
        ),
      ),
    );
  }

  void _handleAddCareer(BuildContext context) async {
    Navigator.pop(context);
    await Navigator.pushNamed(context, Routes.CAREER_ENROLL);
  }

  Widget _buildCareerName() {
    return Text(
      currentProgram.career.name,
      style: TextStyle(
        fontSize: 16.0,
        color: Colors.black54,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildInstitutionName() {
    return Text(
      currentProgram.institution.name,
      style: TextStyle(fontSize: 14.0, color: Colors.black45),
    );
  }

  Widget _buildCareerCodename() {
    return CircleAvatar(
      backgroundColor: Colors.white,
      child: Text(
        currentProgram.career.codename,
        style: TextStyle(fontSize: 25.0, color: Colors.black87),
      ),
    );
  }
}
