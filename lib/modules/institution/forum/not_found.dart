import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/modules/institution/forum/bloc/cubit.dart';
import 'package:universy/widgets/paddings/edge.dart';

class ForumPublicationNotFoundWidget extends StatelessWidget {
  const ForumPublicationNotFoundWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _buildFloatingActionButton(context),
      body: SymmetricEdgePaddingWidget.horizontal(
          paddingValue: 6,
          child: Center(
            child: Text(
              "No se encontraron publicaciones en el foro",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          )),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        _onFloatingPressed(context);
      },
      child: Icon(
        Icons.add,
        color: Colors.white,
        size: 40,
      ),
      backgroundColor: Colors.amber,
    );
  }

  void _onFloatingPressed(BuildContext context) async {
    BlocProvider.of<InstitutionForumCubit>(context).createNewForumPublicationFromNotFoundState();
  }
}
