import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:universy/services/factory.dart';
import 'package:universy/util/object.dart';

import 'bloc/builder.dart';
import 'bloc/cubit.dart';

class ProfileModule extends StatefulWidget {
  @override
  _ProfileModuleState createState() => _ProfileModuleState();
}

class _ProfileModuleState extends State<ProfileModule> {
  ProfileCubit _profileCubit;

  @override
  void didChangeDependencies() {
    if (isNull(_profileCubit)) {
      var sessionFactory = Provider.of<ServiceFactory>(context, listen: false);
      var profileService = sessionFactory.profileService();
      var accountService = sessionFactory.accountService();
      this._profileCubit = ProfileCubit(profileService, accountService);
      this._profileCubit.toDisplay();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _profileCubit,
      child: BlocBuilder(
        cubit: _profileCubit,
        builder: ProfileStateBuilder().builder(),
      ),
    );
  }
}
