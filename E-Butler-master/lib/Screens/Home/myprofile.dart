import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebutler/Model/user.dart';
import 'package:ebutler/Shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ebutler/Model/listprofiledetail.dart';

class MyProfile extends StatefulWidget {
  const MyProfile ({ Key key }) : super(key: key);
  static const routeName = '/MyAccount';

  @override
  _State createState() => _State();
}

class _State extends State<MyProfile> {

  List<ListProfile> profileList = [
    ListProfile(title: 'History')
  ];

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    String uid = user.uid;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("My Profile", style: TextStyle(color: kPrimaryColor)),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              StreamBuilder(
                stream: Firestore.instance.collection('users').document(uid).snapshots(),
                builder: (context, snapshot) {
                  if(!snapshot.hasData){
                    return Text('Data User tidak ada');
                  }

                  return Card(
                    color: kPrimaryColor,
                    child: ListTile(
                      title: Text(snapshot.data['name'], style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                      subtitle: Text(snapshot.data['email'], style: TextStyle(color: Colors.white60)),
                    ),
                  );
                },
              ),
              
              const SizedBox(height: 10),

              //text "Accounts"
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(7),
                child: Text("Account", style: TextStyle(fontSize: 11)),
              ),
              
              // ListView.builder(
              //   itemCount: profileList.length,
              //   itemBuilder: (context, index) {
              //     ListProfile profile = profileList[index];

              //     return Card(
              //       child: ListTile(
              //         title: Text(profile.title),
              //         trailing: Icon(Icons.arrow_forward),
              //       ),
              //     );
              //   },
              // ),
              
            ],
          ),
        ),
      ),
    );
  }
}