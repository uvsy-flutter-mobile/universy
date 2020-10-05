import 'package:flutter/material.dart';
import 'package:universy/modules/institution/forum/bloc/states.dart';
import 'package:universy/modules/institution/forum/forum_view.dart';
import 'package:universy/modules/institution/forum/items/publication/new_publication.dart';
import 'package:universy/modules/institution/forum/items/publication/publication_detail.dart';
import 'package:universy/modules/institution/forum/items/publication/publication_detail_new_comment.dart';
import 'package:universy/modules/institution/forum/not_found.dart';
import 'package:universy/util/bloc.dart';
import 'package:universy/widgets/progress/circular.dart';


class InstitutionForumStateBuilder
    extends WidgetBuilderFactory<InstitutionForumState> {
  @override
  Widget translate(InstitutionForumState state) {
    if (state is DisplayState) {
      return ForumViewWidget(forumPublications: state.forumPublications,);
    } else if (state is ForumPublicationsNotFoundState) {
      return ForumPublicationNotFoundWidget();
    }else if (state is AddCommentForumPublicationState) {
      return PublicationDetailNewCommentWidget(forumPublication:state.forumPublication);
    }
    else if (state is DisplayForumPublicationState) {
      return PublicationDetailWidget(forumPublication:state.forumPublication);
    }
    else if (state is CreateForumPublicationState) {
      return NewPublicationWidget(subjects:state.institutionSubjects,profile: state.profile,);
    }
    return CenterSizedCircularProgressIndicator();
  }
}
