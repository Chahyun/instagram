import 'package:flutter/material.dart';

class Upload extends StatelessWidget {
  const Upload({Key? key, this.userImage, this.setUserContent, this.addData}) : super(key: key);
final userImage;
final setUserContent;
final addData;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            addData();
            Navigator.pop(context);
            // Navigator.pop(context);
          },
              icon: Icon(Icons.send)),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.file(userImage),
          TextField(decoration: InputDecoration(
            labelText: "Content",
            labelStyle:TextStyle(color: Colors.red, fontSize: 25),
          ), style:TextStyle(color: Colors.black),
            onChanged: (text){
            setUserContent(text);
            },
          ),
          IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: Icon(Icons.close)),
        ],
      )
    );
  }
}
