import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:hello/util/Logger.dart';

class StarredWords extends StatelessWidget {
  final TAG = 'StarredWords';
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _wordPairSet = new Set<WordPair>();

  StarredWords(Set<WordPair> wordPairSet) {
    if (wordPairSet != null) {
      this._wordPairSet.addAll(wordPairSet);
    }
  }

  _onBackPressed(BuildContext context) {
    Logger.d(TAG, '_onBackPressed');
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final tiles = _wordPairSet.map(
      (pair) {
        return new ListTile(
          title: new Text(
            pair.asCamelCase,
            style: _biggerFont,
          ),
        );
      },
    );
    final divided = ListTile
        .divideTiles(
          context: context,
          tiles: tiles,
        )
        .toList();

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Starred List'),
        leading: new IconButton(
            icon: new Icon(Icons.close),
            onPressed: () => _onBackPressed(context)),
      ),
      body: new ListView(
        children: divided,
      ),
    );
  }
}
