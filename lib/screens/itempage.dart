import 'dart:convert';
import 'package:ecommerce/widgets/appbar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ItemPage extends StatefulWidget {
  final int index;

  const ItemPage({Key? key, required this.index}) : super(key: key);

  @override
  State<ItemPage> createState() => _ItemPageState();
}

List<dynamic> products = [];

class _ItemPageState extends State<ItemPage> {
  bool isLoading = true;

  @override
  void initState() {
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
      body: Container(
        padding: EdgeInsets.all(20),
        child: isLoading
            ? CircularProgressIndicator() // Display a loader while fetching data
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  if (products.isNotEmpty && widget.index < products.length)
                    Center(
                      child: SizedBox(
                          height: 300,
                          width: 300,
                          child: Image.network(
                            products[widget.index]['images'][0] ?? '',
                            fit: BoxFit.fill,
                          )),
                    ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    products[widget.index]['title'] ?? '',
                    style: TextStyle(color: Colors.black, fontSize: 25),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    products[widget.index]['description'] ?? '',
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Price: \$ '),
                  Text(
                    products[widget.index]['price'].toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 90,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Back',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
