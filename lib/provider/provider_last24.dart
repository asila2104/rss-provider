import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:dart_rss/dart_rss.dart';
import 'package:rss/utils/rss.dart';

class Last24_Provider with ChangeNotifier {
  List<RssItem>? news;
  bool isLoad = false;
  bool error = false;
  final Api _newsProvider = LentaLastNews24Provider();
  Future<void> loadNews() async {
    try {
      news = await _newsProvider.getNews();
      isLoad = true;

      notifyListeners();
    } catch (e) {}
  }

  Future<void> reloadNews() async {}
}
