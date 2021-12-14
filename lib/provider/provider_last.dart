import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:dart_rss/dart_rss.dart';
import 'package:rss/utils/rss.dart';

class Last_Provider with ChangeNotifier {
  List<RssItem>? news2;
  bool isLoad = false;
  bool error = false;
  final Api _newsProvider = LentaLastNewsProvider();
  Future<void> loadNews() async {
    try {
      news2 = await _newsProvider.getNews();
      isLoad = true;

      notifyListeners();
    } catch (e) {}
  }

  Future<void> reloadNews() async {}
}
