import 'package:flutter/material.dart';
import 'package:universy/widgets/paddings/edge.dart';

class ProfileNotFoundWidget extends StatefulWidget {
  @override
  _ProfileNotFoundState createState() => _ProfileNotFoundState();
}

class _ProfileNotFoundState extends State<ProfileNotFoundWidget> {
  @override
  Widget build(BuildContext context) {
    return SymmetricEdgePaddingWidget.horizontal(
      paddingValue: 90.0,
      child: Container(
        color: Colors.transparent,
        alignment: AlignmentDirectional.topCenter,
        child: Column(
          children: <Widget>[
            SizedBox(height: 125.0),
            _buildTitle(),
            SizedBox(height: 50.0),
            _buildSubtitle(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      "No se encontró un perfil creado",
      //AppText.getInstance().get("institution.subjects.notFound.title"),
      textAlign: TextAlign.center,
      style: Theme.of(context).primaryTextTheme.headline2,
    );
  }

  Widget _buildSubtitle() {
    return Text(
      "Por favor, creá tu perfil para poder acceder al foro de Universy.",
      //AppText.getInstance().get("institution.subjects.notFound.subtitle"),
      textAlign: TextAlign.center,
      style: Theme.of(context).primaryTextTheme.headline3,
    );
  }
}
