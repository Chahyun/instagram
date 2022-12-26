import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Store1 extends ChangeNotifier{
  var name = 'John Kim';
  var follower = 0;
  var followerState = false;

  follow(){
    if(followerState == false){
      follower++;
      followerState = true;
    }else{
      follower--;
      followerState = false;
    }
    notifyListeners();
  }
}

class Store2 extends ChangeNotifier{
  var profileImg = [];

  getData()async{
    var result = await http.get(Uri.parse('https://codingapple1.github.io/app/profile.json'));
    profileImg = jsonDecode(result.body);
    notifyListeners();
    print(profileImg);
  }
}