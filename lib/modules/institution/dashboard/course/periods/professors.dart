import 'package:flutter/material.dart';
import 'package:universy/model/institution/professor.dart';
import 'package:universy/text/formaters/professor.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/paddings/edge.dart';

class ProfessorListWidget extends StatelessWidget {
  final List<Professor> _professors;

  ProfessorListWidget({Key key, @required List<Professor> professors})
      : this._professors = professors,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        color: Color(0xffe0e0e0),
        child: SymmetricEdgePaddingWidget.vertical(
          paddingValue: 10,
          child: Wrap(
            children: <Widget>[
              _buildProfessorTitle(),
              _professors.isNotEmpty
                  ? _buildProfessorsNames()
                  : _buildProfessorNotFound(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfessorNotFound() {
    return Center(
      child: Text(
        AppText.getInstance()
            .get("institution.dashboard.course.labels.noProfessors"),
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  Widget _buildProfessorTitle() {
    return SymmetricEdgePaddingWidget.horizontal(
      paddingValue: 15,
      child: Text(
        AppText.getInstance()
            .get("institution.dashboard.course.labels.professors"),
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget _buildProfessorsNames() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (context, position) {
        return _buildSingleProfessorName(_professors[position]);
      },
      itemCount: _professors.length,
    );
  }

  Widget _buildSingleProfessorName(Professor professor) {
    return Center(
      child: Text(
        ProfessorNameFormatter(professor).format(),
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}
