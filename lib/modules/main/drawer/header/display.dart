import 'package:flutter/material.dart';
import 'package:universy/model/institution/queries.dart';

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
      otherAccountsPictures: _buildOtherPrograms(),
    );
  }

  List<Widget> _buildOtherPrograms() {
    return otherPrograms.map(_buildProgramWidget).toList();
  }

  Widget _buildProgramWidget(InstitutionProgramInfo programInfo) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      child: Text(
        programInfo.career.codename,
        style: TextStyle(
          fontSize: 16.0,
        ),
      ),
    );
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
