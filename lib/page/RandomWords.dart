import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:hello/page/StarredWords.dart';
import 'package:hello/util/Logger.dart';

class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new RandomWordsState();
  }
}

class RandomWordsState extends State<RandomWords> {
  final TAG = 'RandomWordsState';

  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _savedWordPairSet = new Set<WordPair>();

  Widget _buildRow(WordPair wordPair) {
    final alreadySaved = _savedWordPairSet.contains(wordPair);

    return new ListTile(
      title: new Text(
        wordPair.asCamelCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _savedWordPairSet.remove(wordPair);
          } else {
            _savedWordPairSet.add(wordPair);
          }
        });
      },
    );
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) {
          return new Divider();
        }

        final index = i ~/ 2;
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  void _pushSave() {
    Logger.d(TAG, 'push save');
    Navigator.push(context, new MaterialPageRoute(builder: (context) {
      return new StarredWords(_savedWordPairSet);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Startup Name Generator'),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _pushSave),
        ],
      ),
      body: _buildSuggestions(),
    );
  }
}
