import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Map<String, dynamic>? _userInfo;

  Future<User?> signup(String email, String password, bool isSeller, String username) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _firestore.collection('User').doc(userCredential.user!.uid).set({
        'isSeller': isSeller,
        'email': email,
        'username': username,
      });

      return userCredential.user;
    } catch (e) {
      print("Signup Error: $e");
      return null;
    }
  }



  Future<void> signout() async {
    await _auth.signOut();
  }

  Future<bool> isSeller(User user) async {
    try {
      DocumentSnapshot userDoc = await _firestore.collection('User').doc(user.uid).get();
      return userDoc.exists ? userDoc['isSeller'] : false;
    } catch (e) {
      print("Check Seller Error: $e");
      return false;
    }
  }

  Future<Map<String, dynamic>?> getUserInfo(String userId) async {
    try {
      if (userId != null) {
        DocumentSnapshot userDoc = await _firestore.collection('User').doc(userId).get();
        return userDoc.exists ? userDoc.data() as Map<String, dynamic> : null;
      } else {

        print("Error: userId is empty or null");
        return null;
      }
    } catch (e) {
      print("Error fetching user info: $e");
      return null;
    }
  }



  void setUserInfo(Map<String, dynamic> userInfo) {
    _userInfo = userInfo;
  }

  String getUserName() {
    return _userInfo?['username'] ?? 'User';
  }

  Future<void> addArticle(String name, String category, int quantity, double price, String image, String description) async {
    try {
      await _firestore.collection('articles').add({
        'name': name,
        'category': category,
        'quantity': quantity,
        'price': price,
        'image': image,
        'description': description,
      });
    } catch (e) {
      print("Add Article Error: $e");
    }
  }

  Future<List<Map<String, dynamic>>> getArticles() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('articles').get();
      return querySnapshot.docs.map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      print("Get Articles Error: $e");
      return [];
    }
  }

}
