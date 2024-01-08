import 'package:flutter/material.dart';
import '../models/article.dart';

class SellerScreen extends StatefulWidget {
  const SellerScreen({Key? key, required String sellerName}) : super(key: key);

  @override
  _SellerScreenState createState() => _SellerScreenState();
}

class _SellerScreenState extends State<SellerScreen> {
  List<Article> articles = [
    Article(name: 'Product 1', category: 'Category 1', quantity: 10, price: 20.0),
    Article(name: 'Product 2', category: 'Category 2', quantity: 5, price: 15.0),
  ];

  bool isAllSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stock"),
        actions: [
          GestureDetector(
            onTap: () {
              _showAccountDialog(context);
            },
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/seller_image.png'),
            ),
          ),
          IconButton(
            onPressed: () {
              _navigateToLogout(context);
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _navigateToCreateProduct(context);
                  },
                  child: Text("Create Product"),
                ),
                ElevatedButton(
                  onPressed: () {
                    _navigateToModifyProduct(context);
                  },
                  child: Text("Modify Product"),
                ),
                ElevatedButton(
                  onPressed: () {
                  },
                  child: Text("Delete Product"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isAllSelected = !isAllSelected;
                      articles.forEach((article) {
                        article.isChecked = isAllSelected;
                      });
                    });
                  },
                  child: Text(isAllSelected ? "Deselect All" : "Select All"),
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(articles[index].name),
                      subtitle: Text("${articles[index].quantity} in stock"),
                      trailing: Checkbox(
                        value: articles[index].isChecked,
                        onChanged: (isChecked) {
                          setState(() {
                            articles[index].isChecked = isChecked!;
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Account Information"),
          content: Text("Add your seller account information here."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToCreateProduct(BuildContext context) {
    Navigator.pushNamed(context, '/createproduct');
  }

  void _navigateToModifyProduct(BuildContext context) {
    Navigator.pushNamed(context, '/updateproduct');
  }
  void _navigateToLogout(BuildContext context) {
    Navigator.pushNamed(context,'/');
  }
}
