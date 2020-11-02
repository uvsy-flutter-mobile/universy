import 'package:flutter/material.dart';
import 'package:universy/modules/institution/forum/bloc/states.dart';
import 'package:universy/modules/institution/forum/forum_view.dart';
import 'package:universy/modules/institution/forum/items/filters/filters_view.dart';
import 'package:universy/modules/institution/forum/items/publication/new_publication.dart';
import 'package:universy/modules/institution/forum/items/publication/publication_detail.dart';
import 'package:universy/modules/institution/forum/items/publication/update_publication.dart';
import 'package:universy/modules/institution/forum/not_found.dart';
import 'package:universy/util/bloc.dart';
import 'package:universy/widgets/progress/circular.dart';

class InstitutionForumStateBuilder extends WidgetBuilderFactory<InstitutionForumState> {
  @override
  Widget translate(InstitutionForumState state) {
    if (state is DisplayState) {
      return ForumViewWidget(forumPublications: state.forumPublications, profile: state.profile);
    } else if (state is ForumPublicationsNotFoundState) {
      return ForumPublicationNotFoundWidget();
    } else if (state is DisplayForumPublicationDetailState) {
      return PublicationDetailWidget(
          forumPublication: state.forumPublication, profile: state.profile,listComments: state.listComment,);
    } else if (state is UpdateForumPublicationState) {
      return UpdatePublicationWidget(
          forumPublication: state.forumPublication,
          profile: state.profile,
          subjects: state.institutionSubjects,
          commissions: state.listCommissions);
    } else if (state is CreateForumPublicationState) {
      return NewPublicationWidget(
        subjects: state.institutionSubjects,
        profile: state.profile,
        commissions: state.listCommissions,
      );
    } else if (state is FilterForumPublicationsState) {
      return FiltersViewWidget(
        subjects: state.institutionSubjects,
      );
    }
    return CenterSizedCircularProgressIndicator();
  }
}
