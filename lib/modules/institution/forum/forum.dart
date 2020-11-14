import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:universy/modules/institution/forum/bloc/builders/builder.dart';
import 'package:universy/modules/institution/forum/bloc/cubit.dart';
import 'package:universy/modules/institution/forum/bloc/states.dart';
import 'package:universy/services/factory.dart';
import 'package:universy/system/assets.dart';
import 'package:universy/text/text.dart';
import 'package:universy/util/object.dart';
import 'package:universy/widgets/decorations/box.dart';

class InstitutionForumModule extends StatefulWidget {
  _InstitutionForumModuleState createState() => _InstitutionForumModuleState();
}

class _InstitutionForumModuleState extends State<InstitutionForumModule> {
  InstitutionForumCubit _forumCubit;

  @override
  void didChangeDependencies() {
    if (isNull(_forumCubit)) {
      var sessionFactory = Provider.of<ServiceFactory>(context, listen: false);
      var careerService = sessionFactory.studentCareerService();
      var institutionService = sessionFactory.institutionService();
      var profileService = sessionFactory.profileService();
      var forumService = sessionFactory.forumService();
      this._forumCubit =
          InstitutionForumCubit(careerService, institutionService, profileService, forumService);
      this._forumCubit.fetchPublications(false,[]);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocProvider(
        create: (context) => _forumCubit,
        child: Container(
          decoration: assetImageDecoration(Assets.UNIVERSY_CITY_BACKGROUND),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: _buildAppBar(context),
            body: _buildBody(),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => {_arrowBackOnPressed(context)},
      ),
      title: Text(AppText.getInstance().get("institution.forum.title")),
      elevation: 10.0,
      automaticallyImplyLeading: true,
    );
  }

  void _arrowBackOnPressed(BuildContext context) {
    if (_forumCubit.state is DisplayState ||
        _forumCubit.state is ForumPublicationsNotFoundState ||
        _forumCubit.state is CareerNotCreatedState ||
        _forumCubit.state is ProfileNotCreatedState) {
      Navigator.pop(context);
    } else {
      _forumCubit.fetchPublications(false,[]);
    }
  }

  Widget _buildBody() {
    return BlocBuilder(
      cubit: _forumCubit,
      builder: InstitutionForumStateBuilder().builder(),
    );
  }
}
