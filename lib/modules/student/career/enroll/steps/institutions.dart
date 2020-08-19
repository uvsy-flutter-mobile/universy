import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universy/model/institution/institution.dart';
import 'package:universy/services/factory.dart';
import 'package:universy/widgets/future/future_widget.dart';
import 'package:universy/widgets/tiles/list.dart';

class InstitutionStep extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureWidget(
      fromFuture: _fetchInstitutions(context),
      onData: (institutions) =>
          _InstitutionStepWidget(institutions: institutions),
    );
  }

  Future<List<Institution>> _fetchInstitutions(BuildContext context) {
    var institutionService =
        Provider.of<ServiceFactory>(context, listen: false) //
            .institutionService();
    return institutionService.getInstitutions();
  }
}

class _InstitutionStepWidget extends StatelessWidget {
  final List<Institution> institutions;

  const _InstitutionStepWidget({Key key, this.institutions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(institutions);
    return ListView(
      children: institutions
          .map((i) => Card(
                  child: ListTile(
                title: Text(i.name),
                subtitle: Text(i.codename),
              )))
          .toList(),
    );
  }
}
