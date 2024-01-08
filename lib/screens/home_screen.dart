import 'package:flutter/material.dart';
import '../services/firebase_service.dart';
import 'ShoppingCartPage.dart';

class HomeScreen extends StatelessWidget {
  final FirebaseService _firebaseService = FirebaseService();
  final String userId;

  HomeScreen({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
            onPressed: () {
              _navigateToCart(context, []);
            },
            icon: Icon(Icons.shopping_cart),
          ),
        ],
      ),
      drawer: Drawer(
        child: FutureBuilder<Map<String, dynamic>?>(
          future: _firebaseService.getUserInfo(userId),
          builder: (context, AsyncSnapshot<Map<String, dynamic>?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (!snapshot.hasData || snapshot.data == null) {
              return Text('User data not found');
            }

            Map<String, dynamic> userInfo = snapshot.data!;

            return ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.purple,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/images/seller_image.png'),
                        radius: 30,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Hello, ${userInfo['username']}!",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: Text('Account Information'),
                  onTap: () {
                    _showAccountBottomSheet(context, userInfo);
                  },
                ),
                ListTile(
                  title: Text('Logout'),
                  onTap: () {
                    _logout(context);
                  },
                ),
              ],
            );
          },
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _firebaseService.getArticles(),
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          List<Map<String, dynamic>> availableItems = snapshot.data ?? [];

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
              itemCount: availableItems.length,
              itemBuilder: (context, index) {
                return _buildItemCard(context, availableItems[index]);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildItemCard(BuildContext context, Map<String, dynamic> item) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(item['name']),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              _addToCart(context, item['name']);
            },
            child: Text("Add to Cart"),
          ),
        ],
      ),
    );
  }

  void _showAccountBottomSheet(BuildContext context, Map<String, dynamic> userInfo) {
  }

  void _navigateToCart(BuildContext context, List<String> cartItems) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ShoppingCartPage(cartItems: cartItems)),
    );
  }

  void _addToCart(BuildContext context, String item) {
  }

  void _logout(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/');
  }
}
