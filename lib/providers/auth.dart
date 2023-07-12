import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shops/main.dart';
import '../screens/product_overview_Screen.dart';
import 'package:flutter/foundation.dart';
import 'package:shops/screens/product_overview_Screen.dart';

class Auth with ChangeNotifier {
  late String _token;
  late DateTime _expiryDate;
  late String _userId;
  late String uid;

  Future<void> signup(String email, String password) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final UserCredential userCredential = await _auth
        .createUserWithEmailAndPassword(email: email, password: password);

    // Save additional user details to Firestore
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.user!.uid)
        .set({
      'email': userCredential.user!.email,
    });
    uid = userCredential.user!.uid;
    var sharedPref = await SharedPreferences.getInstance();
    sharedPref.setBool(MyApp.keyLogin, true);
  }

  Future<void> login(String email, String password) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _auth.currentUser!.reload();
    } on FirebaseAuthException catch (err) {
      throw err;
    }
  }

  // Navigate to the home screen on successful signup
  // Navigator.push(
  //   context,
  //   MaterialPageRoute(builder: (context) => HomeScreen()),
  // );
  // } catch (e) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Error'),
  //         content: Text(e.toString()),
  //         actions: <Widget>[
  //           FlatButton(
  // child: Text('OK'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
