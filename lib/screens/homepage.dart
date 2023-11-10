import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
        appBar: AppBar(
          title: Center(child: Text('Rollo Store')),
        ),
        body: FutureBuilder(
          future: getProducts(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              return Text('Data Oke');
            }else{
              return Text('Data Error');
            }
          },
        ));
  }
}
