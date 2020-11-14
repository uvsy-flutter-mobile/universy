import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/modules/institution/forum/bloc/cubit.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/buttons/raised/rounded.dart';
import 'package:universy/widgets/paddings/edge.dart';

class ForumPublicationNotFoundWidget extends StatelessWidget {
  final bool _isFiltering;

  const ForumPublicationNotFoundWidget({
    Key key,
    bool isFiltering,
  })  : this._isFiltering = isFiltering,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: _buildFloatingActionButton(context),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              AppText.getInstance().get("institution.forum.publicationNotFound.errorMessage"),
              style: Theme.of(context).primaryTextTheme.subtitle1,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 15,
            ),
            (_isFiltering) ? _buildRefreshButton(context) : Container(),
          ],
        ),
      ),
    );
  }

  Widget _buildRefreshButton(BuildContext context) {
    return CircularRoundedRectangleRaisedButton.general(
      color: Theme.of(context).buttonColor,
      radius: 10,
      child: AllEdgePaddedWidget(
        padding: 9.0,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.refresh,
              color: Colors.white,
              size: 30,
            ),
            Text(
              AppText.getInstance().get("institution.forum.publicationNotFound.buttonMessage"),
              style: Theme.of(context).primaryTextTheme.button,
            )
          ],
        ),
      ),
      onPressed: () => _returnToFilter(context),
    );
  }

  void _returnToFilter(BuildContext context) {
    BlocProvider.of<InstitutionForumCubit>(context).filterForumPublicationsStateFromNotFound();
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
