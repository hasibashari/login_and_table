// home_screen.dart
import 'package:flutter/material.dart';

class Product {
  final String name;
  final double price;

  Product(this.name, this.price);
}

class HomeScreen extends StatefulWidget {
  final String userEmail;

  const HomeScreen(this.userEmail, {Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> products = [
    Product('Ayam Geprek', 20.000),
    Product('Nasi Goreng', 15.000),
    Product('Rendang', 15.000),
    Product('Daging Sapi', 25.000),
    // Add other initial products as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Welcome to the Home Screen!"),
          const SizedBox(height: 16),
          Text("User Email: ${widget.userEmail}"),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        products[index].name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Rp. ${products[index].price.toStringAsFixed(3)}',
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        products.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _showAddProductDialog(context);
            },
            child: const Text('Add Product'),
          ),
        ],
      ),
    );
  }

  Future<void> _showAddProductDialog(BuildContext context) async {
    String newProductName = '';
    double newProductPrice = 0.0;

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Product'),
          content: Column(
            children: [
              TextField(
                onChanged: (value) {
                  newProductName = value;
                },
                decoration: const InputDecoration(
                  hintText: 'Enter product name',
                ),
              ),
              TextField(
                onChanged: (value) {
                  // Parse the entered value as a double
                  newProductPrice = double.tryParse(value) ?? 0.0;
                },
                decoration: const InputDecoration(
                  hintText: 'Enter product price',
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (newProductName.isNotEmpty) {
                    products.add(Product(newProductName, newProductPrice));
                  }
                });
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
