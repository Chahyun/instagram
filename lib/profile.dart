import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'store.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.watch<Store1>().name),),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: ProfileBody()),
          SliverGrid(delegate: SliverChildBuilderDelegate(
              (c,i) => Image.network(context.watch<Store2>().profileImg[i]),childCount: context.watch<Store2>().profileImg.length),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3)),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: IconButton(onPressed: (){
          Navigator.pop(context);
        },icon: Icon(Icons.backspace),),
      ),
    );
  }
}
class ProfileBody extends StatelessWidget {
  const ProfileBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey,
        ),
        Text("팔로워 ${context.watch<Store1>().follower}명"),
        ElevatedButton(onPressed: (){
          context.read<Store1>().follow();
        }, child: Text("팔로우"),),
        ElevatedButton(onPressed: (){

          context.read<Store2>().getData();
        }, child: Text("사진가져오기"),)
      ],
    );
  }
}