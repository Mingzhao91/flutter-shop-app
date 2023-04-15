import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavourite = false,
  });

  Uri getUrl({String id = ''}) {
    return Uri.parse(
        'https://flutter-my-shop-1003c-default-rtdb.firebaseio.com/products${id == '' ? '' : '/$id'}.json');
  }

  void _setFavValue(bool newVal) {
    isFavourite = newVal;
    notifyListeners();
  }

  Future<void> toggleFavouritesStatus() async {
    final oldStatus = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();
    try {
      final response = await http.patch(
        getUrl(id: id),
        body: json.encode(
          {
            'isFavourite': isFavourite,
          },
        ),
      );
      // The http package only throws its own error for get and post requests if the server returns an error status code. for patch, put and delete, it doesn’t do that.
      if (response.statusCode >= 400) {
        _setFavValue(oldStatus);
      }
    } catch (error) {
      _setFavValue(oldStatus);
    }
  }
}
