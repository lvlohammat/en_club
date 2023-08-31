// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../helpers/db_helper.dart';

class EnglishItems with ChangeNotifier {
  List<EnglishItem> _items = [];
  List<EnglishItem> get items => _items;
  List<EnglishItem> _savedItems = [];
  List<EnglishItem> get savedItems => _savedItems;
  List<EnglishItem> _filtredItems = [];
  List<EnglishItem> get filtredItems => _filtredItems;

  Future<void> fetchItems() async {
    fetchSavedItems();
    QueryBuilder<ParseObject> query = QueryBuilder(ParseObject('EnglishItems'));
    try {
      final List<EnglishItem> extractedItems = [];
      final response = await query.query();
      if (response.success && response.results != null) {
        final results = response.results as List<ParseObject>;
        results
            .map((item) => extractedItems.add(EnglishItem.fromJson(item)))
            .toList();
        _items = extractedItems.reversed.toList();
        notifyListeners();
      } else {
        throw response.error!;
      }
    } catch (e) {
      // Handle the error
      debugPrint('Error fetching items: $e');
    }
  }

  Future<void> fetchSavedItems() async {
    final db = await DbHelper.getData('items');
    final List<EnglishItem> data = [];
    for (var e in db) {
      data.add(
        EnglishItem(
          title: e['title'],
          story: e['story'],
          id: e['id'],
          name: e['name'],
          audioUrl: e['audioLink'],
          episode: e['episode'],
          imageUrl: e['imageUrl'],
          lesson: e['lesson'],
          script: e['script'],
          tag: stringToTag(e['tag']),
        ),
      );
      data.sort(
        (a, b) => a.episode!.compareTo(b.episode!),
      );
      _savedItems = data;
      notifyListeners();
    }
  }

  Future<void> saveItem(EnglishItem item) async {
    final itemInDb = await DbHelper.findById(item.id!, 'items');
    if (itemInDb.isNotEmpty) {
      await DbHelper.deleteItemFromDb(item.id!, 'items');
      savedItems.removeWhere(
        (element) => element.id == item.id,
      );
    } else {
      await DbHelper.insert(
        'items',
        {
          'id': item.id,
          'name': item.name,
          'title': item.title,
          'story': item.story,
          'script': item.script,
          'lesson': item.lesson,
          'audioUrl': item.audioUrl,
          'imageUrl': item.imageUrl,
          'tag': tagToString(item.tag!),
          'episode': item.episode,
        },
      );
      _savedItems.add(item);
    }
    notifyListeners();
  }

  EnglishItem findById(String id, bool isSaved) {
    if (isSaved) {
      return _savedItems.firstWhere((element) => element.id == id);
    }
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> fetchFiltredItems(tag) async {
    QueryBuilder<ParseObject> query = QueryBuilder(ParseObject('EnglishItems'));
    query.whereEqualTo('tag', tagToString(tag));

    final List<EnglishItem> extractedItems = [];
    final response = await query.query();

    if (response.success && response.results != null) {
      final results = response.results as List<ParseObject>;
      results.map((item) {
        extractedItems.add(EnglishItem.fromJson(item));
      }).toList();

      _filtredItems = extractedItems;
      notifyListeners();
    } else {
      throw response.error!;
    }
  }

  List<String> getNameOfItems(List<EnglishItem> items) {
    final nameList = <String>{};
    for (var element in items) {
      nameList.add(element.name!);
    }
    nameList.toList().sort();
    return nameList.toList();
  }

  EnglishItem firstItemByName(String name, List<EnglishItem> items) =>
      items.firstWhere((element) => element.name == name);

  List<EnglishItem> getItemsByName(String name, List<EnglishItem> items) =>
      items.where((element) => element.name == name).toList();

  EnglishItem? playerItem;

  void changePlayerItem(EnglishItem item) {
    playerItem = item;
    notifyListeners();
  }
}

class EnglishItem {
  final String? id;
  final String? name;
  final String? title;
  final String? story;
  final String? imageUrl;
  final String? audioUrl;
  final String? lesson;
  final String? script;
  final int? episode;
  final Tag? tag;

  EnglishItem({
    required this.id,
    required this.name,
    required this.title,
    required this.story,
    required this.imageUrl,
    required this.audioUrl,
    required this.lesson,
    required this.script,
    required this.episode,
    required this.tag,
  });

  factory EnglishItem.fromJson(ParseObject object) {
    return EnglishItem(
      id: object.get<String>('objectId'),
      title: object.get<String>('title'),
      name: object.get<String>('name'),
      story: object.get<String>('story'),
      imageUrl: object.get<String>('imageUrl'),
      audioUrl: object.get<String>('audioUrl'),
      lesson: object.get<String>('lesson'),
      script: object.get<String>('script'),
      episode: object.get<int>('episode'),
      tag: stringToTag(object.get<String>('tag')),
    );
  }
}

enum Tag { drama, everyday, business }

String tagToString(Tag tag) {
  switch (tag) {
    case Tag.drama:
      return 'drama';
    case Tag.everyday:
      return 'everyday';
    case Tag.business:
      return 'Business';

    default:
      return 'business';
  }
}

Tag stringToTag(String? tag) {
  switch (tag) {
    case 'drama':
      return Tag.drama;
    case 'everyday':
      return Tag.everyday;
    case 'Business':
      return Tag.business;

    default:
      return Tag.business;
  }
}
