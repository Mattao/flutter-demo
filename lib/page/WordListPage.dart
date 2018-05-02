import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:hello/page/StarredWordListPage.dart';
import 'package:hello/util/Logger.dart';

class WordListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new WordListPageState();
  }
}

class WordListPageState extends State<WordListPage> {
  static const TAG = 'WordListPageState';

  final _wordList = <WordPair>[];
  final _biggerFont = new TextStyle(fontSize: 18.0);
  final _savedWordListSet = new Set<WordPair>();

  Widget _buildItem(WordPair word) {
    final alreadySaved = _savedWordListSet.contains(word);

    return new ListTile(
      title: new Text(
        word.asCamelCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _savedWordListSet.remove(word);
          } else {
            _savedWordListSet.add(word);
          }
        });
      },
    );
  }

  Widget _buildWordList() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) {
          return new Divider();
        }

        final index = i ~/ 2;
        if (index >= _wordList.length) {
          _wordList.addAll(generateWordPairs().take(10));
        }
        return _buildItem(_wordList[index]);
      },
    );
  }

  void _launchStarredWordsPage() {
    Logger.d(TAG, 'launch StarredWordsPage');
    Navigator.push(context, new MaterialPageRoute(builder: (context) {
      return new StarredWordsListPage(_savedWordListSet);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Word List'),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _launchStarredWordsPage),
        ],
      ),
      body: _buildWordList(),
    );
  }
}
