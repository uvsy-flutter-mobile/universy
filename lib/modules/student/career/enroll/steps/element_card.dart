import 'package:flutter/material.dart';
import 'package:universy/util/object.dart';

class ElementCard extends StatelessWidget {
  final String tag;
  final String title;
  final String subtitle;
  final bool selected;
  final bool enabled;
  final VoidCallback onTap;

  const ElementCard(
      {Key key,
      this.tag,
      this.title,
      this.subtitle,
      this.selected,
      this.onTap,
      this.enabled = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: ListTile(
        enabled: enabled,
        onTap: onTap,
        selected: selected,
        leading: _buildLeading(context),
        title: Text(title),
        subtitle: notNull(subtitle) ? Text(subtitle) : null,
      ),
    );
  }

  Widget _buildLeading(BuildContext context) {
    if (notNull(tag)) {
      return CircleAvatar(
        backgroundColor: Colors.white,
        child: Text(tag, style: Theme.of(context).primaryTextTheme.caption),
      );
    }
    return null;
  }
}
