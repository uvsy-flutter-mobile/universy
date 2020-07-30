import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DispatcherListTileItem extends StatelessWidget {
  final bool _selected;
  final String _title;
  final String _subtitle;
  final Function(BuildContext context) _eventDispatcher;

  const DispatcherListTileItem(
      {Key key,
      @required bool selected,
      @required String title,
      @required String subtitle,
      @required Function(BuildContext context) eventDispatcher})
      : this._selected = selected,
        this._title = title,
        this._subtitle = subtitle,
        this._eventDispatcher = eventDispatcher,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _getColor(),
      child: ListTile(
        title: _buildTitle(),
        subtitle: _buildSubtitle(),
        onTap: _eventDispatcher(context),
        selected: _selected,
      ),
    );
  }

  Color _getColor() => _selected ? Colors.amber[100] : Colors.transparent;

  Text _buildTitle() => Text(_title, style: TextStyle(color: Colors.black));

  Text _buildSubtitle() =>
      Text(_subtitle, style: TextStyle(color: Colors.black));
}
