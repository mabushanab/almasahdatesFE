import 'package:almasah_dates/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class favs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onSecondary,
    );
    var appState = context.watch<MyAppState>();
    var list = appState.fav;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('The Favs: ', style: style),
          for (var msg in list) Text(msg.toString(), style: style),
        ],
      ),
    );
  }
}
