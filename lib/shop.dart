import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final auth = FirebaseAuth.instance;

final firestore = FirebaseFirestore.instance;

class shop extends StatefulWidget {
  const shop({Key? key}) : super(key: key);

  @override
  State<shop> createState() => _shopState();
}
class _shopState extends State<shop> {

  getData() async {
    try {
      var result = await auth.createUserWithEmailAndPassword(
        email: "kim@test.com",
        password: "123456",
      );
      result.user?.updateDisplayName('jhon');
      print(result.user);
    } catch (e) {
      print(e);
    }
    if(auth.currentUser?.uid == null){
      print('로그인 안된 상태군요');
    } else {
      print('로그인 하셨네');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(onPressed: (){
        getData();
      },icon: Icon(Icons.abc)),
    );
  }
}
