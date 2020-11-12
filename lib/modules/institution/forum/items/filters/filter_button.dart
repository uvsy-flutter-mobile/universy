import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/model/institution/forum.dart';
import 'package:universy/modules/institution/forum/bloc/cubit.dart';
import 'package:universy/widgets/paddings/edge.dart';

class FilterButtonWidget extends StatefulWidget {
  const FilterButtonWidget({Key key,}) : super(key: key);

  @override
  _FilterButtonWidgetState createState() => _FilterButtonWidgetState();
}

class _FilterButtonWidgetState extends State<FilterButtonWidget> {
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: _buildContentButton(),
    );
  }

  Widget _buildContentButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        SymmetricEdgePaddingWidget.horizontal(paddingValue: 2, child: Icon(Icons.filter_list)),
        Text(
          "Filtrar",
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
        ),
      ],
    );
  }

  void _onTap() {
    BlocProvider.of<InstitutionForumCubit>(context).filterForumPublicationsState();
  }
}
