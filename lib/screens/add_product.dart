import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:toko_online/screens/homepage.dart';
import 'package:http/http.dart' as http;

class AddProduct extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _desController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  AddProduct({super.key});

  Future saveProduct() async {
    final response = await http
        .post(Uri.parse("http://10.0.2.2:8000/api/productsApi"), body: {
      "name": _nameController.text,
      "description": _desController.text,
      "price": _priceController.text,
      "image_url": _imageUrlController.text,
    });

    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
      ),
      body: Form(
        key: _formKey,
        child: Column(children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: "Name"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please Enter Product Name";
              }
              return null;
            },
          ),
          TextFormField(
            controller: _desController,
            decoration: const InputDecoration(labelText: "Description"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please Enter Product Description";
              }
              return null;
            },
          ),
          TextFormField(
            controller: _priceController,
            decoration: const InputDecoration(labelText: "Price"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please Enter Product Price";
              }
              return null;
            },
          ),
          TextFormField(
            controller: _imageUrlController,
            decoration: const InputDecoration(labelText: "Image URL"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please Enter Product Image URL";
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  saveProduct().then((value) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const HomePage()));
                  });
                }
              },
              child: const Text("Save"))
        ]),
      ),
    );
  }
}
