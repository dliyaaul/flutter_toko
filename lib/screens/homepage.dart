import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toko_online/screens/add_product.dart';
import 'package:toko_online/screens/product_detail.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  final String url = 'http://10.0.2.2:8000/api/productsApi';

  Future getProducts() async {
    var response = await http.get(Uri.parse(url));
    print(json.decode(response.body));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddProduct()));
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Center(child: Text('Rollo Store')),
        ),
        body: FutureBuilder(
          future: getProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data['data'].length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 180,
                      child: Card(
                        elevation: 5,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProductDetail(
                                              product: snapshot.data['data']
                                                  [index],
                                            )));
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  padding: const EdgeInsets.all(5),
                                  height: 120,
                                  width: 120,
                                  child: Image.network(
                                    snapshot.data['data'][index]['image_url'],
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        snapshot.data['data'][index]['name'],
                                        style: const TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(snapshot.data['data'][index]
                                          ['description']),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Icon(Icons.edit),
                                        Text(snapshot.data['data'][index]
                                            ['price']),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            } else {
              return const Text('Data Error');
            }
          },
        ));
  }
}
