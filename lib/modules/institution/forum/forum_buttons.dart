import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/model/institution/forum.dart';
import 'package:universy/modules/institution/forum/bloc/cubit.dart';

class ForumButton extends StatelessWidget {
  const ForumButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
    BlocProvider.of<InstitutionForumCubit>(context).createNewForumPublication();
  }
}

class NewCommentButton extends StatelessWidget {
  final ForumPublication forumPublication;

  const NewCommentButton({Key key, ForumPublication forumPublication})
      : this.forumPublication = forumPublication,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.deepPurple,
      child: Icon(
        Icons.add_comment,
        size: 30,
      ),
      onPressed: () {
        _onPressed(context);
      },
    );
  }

  void _onPressed(BuildContext context) async {
    BlocProvider.of<InstitutionForumCubit>(context).addNewComment(this.forumPublication);
  }
}
