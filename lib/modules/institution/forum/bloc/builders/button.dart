import 'package:flutter/material.dart';
import 'package:universy/modules/institution/forum/bloc/states.dart';
import 'package:universy/modules/institution/forum/forum_buttons.dart';
import 'package:universy/util/bloc.dart';

class InstitutionForumStateButtonBuilder extends WidgetBuilderFactory<InstitutionForumState> {
  @override
  Widget translate(InstitutionForumState state) {
    if (state is DisplayState) {
      return ForumButton();
    }else if (state is DisplayForumPublicationState) {
      return NewCommentButton(forumPublication: state.forumPublication);
    }else if (state is AddCommentForumPublicationState) {
      return SizedBox.shrink();
    }
    return SizedBox.shrink();
  }
}
