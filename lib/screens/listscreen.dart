import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:ecommerce/screens/itempage.dart';
import 'package:ecommerce/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

List<dynamic> products = [];

class _ListPageState extends State<ListPage> {
  static List pageNames = ['ListPage', 'ItemPage'];

  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  bool isLoading = true;

  @override
  void initState() {
    //analytics.setAnalyticsCollectionEnabled(true);
    super.initState();
    fetchData(); // Call fetch data on initialization
  }

  Future<void> fetchData() async {
    const url = 'https://dummyjson.com/products';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      products = json['products'];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarx(),
      body: Column(
        children: [
          Expanded(
            child: SizedBox(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  final title = product['title'];
                  final image = product['thumbnail'];
                  return ListTile(
                    visualDensity: const VisualDensity(vertical: 1.5),
                    shape: Border.all(color: Colors.black, width: 1.0),
                    title: Text(title),
                    leading: SizedBox(
                        height: 50, width: 50, child: Image.network(image)),
                    onTap: () {
                      analytics.setAnalyticsCollectionEnabled(true);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ItemPage(index: index),
                        ),
                      );
                      analytics.logEvent(
                          name: 'page_switch',
                          parameters: {'page_name': 'ListPage'});
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
