import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_pro/screens/my_posts.dart';


final _firestore = FirebaseFirestore.instance;
class ServeHall extends StatelessWidget {

  final String idDoc;

   ServeHall({Key? key,required this.idDoc}) : super(key: key);
  late String username;
  late String email;
  late String phone;
  late String weddingDays;
  late String weddingD;
late int i;
  void addPost()
  {
    _firestore.collection('user_details').add({
      'docID':idDoc,
      'username':username,
      'email':email,
      'phone':phone,
      'weddingDays':weddingDays,

    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,

        ),
        drawer: const Drawer(),
        body: ListView(

          children: [

            Container(
              margin: const EdgeInsets.only(top: 80,left: 30,right: 30),
              child: TextFormField(
                decoration: const InputDecoration(
                    labelText: "Name",
                    icon: Icon(Icons.drive_file_rename_outline,color: Colors.pink,),
                    border:  OutlineInputBorder()
                ),
                maxLines: 1,
                autofocus: false,
                keyboardType: TextInputType.name,
                onChanged: (String value) {
                  // print(value);
                  username=value;
                },
              ),

            ),
            Container(
              margin: const EdgeInsets.only(top: 30,left: 30,right: 30),
              child: TextFormField(


                decoration: const InputDecoration(
                    labelText: "E_mail",
                    icon:  Icon(Icons.email,color: Colors.pink,),
                    border:  OutlineInputBorder()
                ),
                maxLines: 1,
                autofocus: false,
                keyboardType: TextInputType.emailAddress,
                onChanged: (String value) {
                  // print(value);
                  email=value;
                },
              ),

            ),

            Container(
              margin: const EdgeInsets.only(top: 30,left: 30,right: 30),
              child: TextFormField(
                decoration: const InputDecoration(
                    labelText: "Phone",
                    icon: Icon(Icons.phone_android_outlined,color:  Colors.pink,),
                    border: OutlineInputBorder()
                ),
                maxLines: 1,
                autofocus: false,
                keyboardType: TextInputType.phone,
                onChanged: (String value) {
                  // print(value);
                  phone=value;
                },
              ),

            ),
            Container(
              margin: const EdgeInsets.only(top: 30,left: 30,right: 30),
              child: TextFormField(


                decoration: const InputDecoration(
                    labelText: "Wedding Date",
                    icon: Icon(Icons.update_outlined,color:  Colors.pink,),
                    border:  OutlineInputBorder()
                ),

                maxLines: 1,
                autofocus: false,
                keyboardType: TextInputType.datetime,

                onChanged: (String value) {

                  weddingDays=value;

                },


              ),

            ),

            Container(
              margin: const EdgeInsets.only(top: 30,left: 30,right: 30),
              child: TextButton.icon(
                onPressed: () {

                      addPost();
                      Navigator.pushNamed(context, PostsMain.id);







                },
                icon: const Icon(Icons.home),
                label: const Text("Ask for a Price"),
                style:ElevatedButton.styleFrom(shadowColor: Colors.black54,elevation: 100,padding: const EdgeInsets.all(20)
                    ,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),primary: Colors.pink) ,
              ),

            ),


          ],
        ),


      ),
    );
  }
}
