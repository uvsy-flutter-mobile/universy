import 'package:flutter/material.dart';

class UserDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orangeAccent,
      child: _buildUserAccountHeader(context),
    );
  }

  Widget _buildUserAccountHeader(BuildContext context) {
    return AccountHeader();
  }
}

class AccountHeader extends StatelessWidget {
  static const String LOADING_SYMBOL = "!";

  @override
  Widget build(BuildContext context) {
    return UserAccountsDrawerHeader(
        decoration: BoxDecoration(color: Colors.orangeAccent),
        accountName: _buildStudentName(),
        accountEmail: _buildStudentUsername(),
        currentAccountPicture: _buildAccountPicture(context),
        otherAccountsPictures: <Widget>[
          CircleAvatar(
              backgroundColor: Colors.white,
              child: Text("IE", style: TextStyle(fontSize: 16.0))),
          CircleAvatar(
              backgroundColor: Colors.white,
              child: Text("IQ", style: TextStyle(fontSize: 16.0))),
          CircleAvatar(backgroundColor: Colors.white, child: Icon(Icons.add)),
        ]);
  }

  Widget _buildStudentName() {
    return Text(
      "Ingenieria en Sistema",
      style: TextStyle(
          fontSize: 16.0, color: Colors.black54, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildStudentUsername() {
    return Text(
      "Facultad Regional Cordoba",
      style: TextStyle(fontSize: 14.0, color: Colors.black45),
    );
  }

  Widget _buildAccountPicture(BuildContext context) {
    return GestureDetector(
      child: CircleAvatar(
        backgroundColor: Colors.white,
        child: Text(
          "IS",
          style: TextStyle(fontSize: 40.0, color: Colors.black87),
        ),
      ),
      onTap: () => _navigateToProfile(context),
    );
  }

  void _navigateToProfile(BuildContext context) {}
}
