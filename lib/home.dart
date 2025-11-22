import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class APICall extends StatefulWidget {
  const APICall({super.key});

  @override
  State<APICall> createState() => _APICallState();
}

class _APICallState extends State<APICall> {
  List products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getchProducts();
  }

  Future<void> getchProducts() async {
    final url = Uri.parse('http://35.73.30.144:2008/api/v1/ReadProduct');
    final response = await http.get(url);

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      setState(() {
        products = [
          {
            "id": 1,
            "title": "Chicken Biryani",
            "description": "Aromatic basmati rice cooked with spiced chicken.",
            "calories": 550
          },
          {
            "id": 2,
            "title": "Beef Curry",
            "description": "Slow-cooked beef in a rich curry gravy.",
            "calories": 620
          },
          {
            "id": 3,
            "title": "Vegetable Khichuri",
            "description": "Rice and lentils cooked with mixed vegetables.",
            "calories": 400
          },
          {
            "id": 4,
            "title": "Pasta Alfredo",
            "description": "Creamy white sauce pasta with parmesan cheese.",
            "calories": 480
          },
          {
            "id": 5,
            "title": "Grilled Sandwich",
            "description": "Toasted sandwich filled with cheese and vegetables.",
            "calories": 310
          },
          {
            "id": 6,
            "title": "Chicken Fry",
            "description": "Crispy deep-fried chicken with spices.",
            "calories": 530
          },
          {
            "id": 7,
            "title": "Egg Curry",
            "description": "Boiled eggs cooked in masala gravy.",
            "calories": 450
          },
          {
            "id": 8,
            "title": "Fruit Salad",
            "description": "Mixed seasonal fruits served chilled.",
            "calories": 250
          },
          {
            "id": 9,
            "title": "Fried Rice",
            "description": "Rice fried with vegetables, egg, and soy sauce.",
            "calories": 500
          },
          {
            "id": 10,
            "title": "Mango Lassi",
            "description": "Sweet yogurt drink blended with ripe mango.",
            "calories": 300
          }
        ];
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food List'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final item = products[index];

          return Card(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            elevation: 3,
            child: ListTile(
              contentPadding:
              EdgeInsets.symmetric(horizontal: 15, vertical: 10),

              title: Text(
                item['title'],
                style:
                TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 6),
                  Text(
                    item['description'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Calories: ${item['calories']}",
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
