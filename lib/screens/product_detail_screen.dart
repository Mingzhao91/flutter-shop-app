import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final productId = routeArgs['id'];

    return Scaffold(
      appBar: AppBar(
        title: Text('title'),
      ),
    );
  }
}
