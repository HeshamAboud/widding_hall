
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:new_pro/screens/search.dart';

import 'my_posts.dart';
final _firestore = FirebaseFirestore.instance;
class UpdatePost extends StatelessWidget {
  final String postId;
   UpdatePost({Key? key, required this.postId}) : super(key: key);
  late String governorate;
  late String region;
  late String hallName;
  late  int capacity;
  late int cost;
  late String link;
  late String details;
  late String name;
  late String phone;
  late String email;
   void addPost()
   {

     _firestore.collection('post').doc(postId).update(
         {
           'governorate': governorate,
           'region': region,
           'hallName': hallName,
           'capacity': capacity,
           'cost': cost ,
           'link': link,
           'details': details,
           'hall_owner_name': name,
           'phone': phone,
           'email': email,


     });
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(

        child: Column(
          children: <Widget>[
            AppBar(
              backgroundColor: Colors.pinkAccent,
              automaticallyImplyLeading: false,
              title: const Text('Choose'),
            ),
            ListTile(
              title: const Text('Search'),

              onTap: () {
                Navigator.pushNamed(context, Search.id);

              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text("ADD HALL"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              TextField(

                //  keyboardType: TextInputType.datetime,

                onChanged: (String value) {
                  // print(value);
                  governorate=value;
                },
                decoration: const InputDecoration(
                  labelText: 'Governorate',
                  prefixIcon: Icon(
                    Icons.location_on,
                    color: Colors.pinkAccent,
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              TextField(




                onChanged: (String value) {
                  // print(value);
                  region=value;
                },
                decoration: const InputDecoration(
                  labelText: 'Region',
                  prefixIcon: Icon(
                      Icons.place_outlined,
                      color: Colors.pinkAccent
                  ),

                  border: OutlineInputBorder(
                  ),

                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              TextField(



                onChanged: (String value) {
                  hallName=value;
                },
                decoration: const InputDecoration(
                  labelText: 'Hall Name',
                  prefixIcon: Icon(
                      Icons.account_balance,
                      color: Colors.pinkAccent
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              TextField(

                keyboardType: TextInputType.datetime,

                onChanged: ( String value) {
                  // print(value);
                  capacity=int.parse(value)  ;
                  //  ca=capacity as int;
                },
                decoration: const InputDecoration(
                  labelText: 'Capacity',
                  prefixIcon: Icon(
                      Icons.reduce_capacity,
                      color: Colors.pinkAccent
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              TextField(

                keyboardType: TextInputType.number,

                onChanged: ( value) {
                  // print(value);
                  cost=int.parse(value)  ;
//                   c=cost as int;
                },

                decoration: const InputDecoration(
                  labelText: 'Cost',
                  prefixIcon: Icon(
                      Icons.attach_money,
                      color: Colors.pinkAccent
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              TextField(

                keyboardType: TextInputType.url,

                onChanged: (String value) {
                  link=value;
                },
                decoration: const InputDecoration(
                  labelText: 'The Link Of Location',
                  prefixIcon: Icon(
                      Icons.link,
                      color: Colors.pinkAccent
                  ),
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(
                height: 15.0,
              ),
              TextField(

                onChanged: (String value) {
                  // print(value);
                  details=value;
                },
                decoration: const InputDecoration(
                  labelText: 'The Details Of Hall ',
                  prefixIcon: Icon(
                      Icons.my_library_books,
                      color: Colors.pinkAccent
                  ),

                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                child: Column(
                  children: [
                    const Text("Contact Information",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextField(

                      //  keyboardType: TextInputType.datetime,


                      onChanged: (String value) {
                        //  print(value);
                        name=value;
                        print(name);
                      },
                      decoration: const InputDecoration(
                        labelText: 'Name ',
                        prefixIcon: Icon(
                            Icons.drive_file_rename_outline,
                            color: Colors.pinkAccent
                        ),

                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextField(

                      keyboardType: TextInputType.phone,


                      onChanged: (String value) {
                        phone=value;
                        print(phone);
                      },
                      decoration: const InputDecoration(
                        labelText: 'Phone ',
                        prefixIcon: Icon(
                            Icons.phone_android,
                            color: Colors.pinkAccent
                        ),

                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextField(

                      keyboardType: TextInputType.emailAddress,


                      onChanged: (String value) {
                        // print(value);
                        email=value;

                      },
                      decoration: const InputDecoration(
                        labelText: 'E-mail',
                        prefixIcon: Icon(
                            Icons.email_outlined,
                            color: Colors.pinkAccent
                        ),

                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Container(

                width: double.infinity,
                height: 50,
                color: Colors.pinkAccent,
                child: MaterialButton(
                  onPressed: () {
                    if(
                    governorate.isEmpty ||
                        region .isEmpty||
                        hallName.isEmpty||
                        link.isEmpty||

                        details.isEmpty||
                        name.isEmpty||
                        phone.isEmpty||
                        email.isEmpty
                    ) {
                      AlertDialog(
                        title: const Text('Add post error'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: const <Widget>[
                              Text('All TextField mast be completed '),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );;
                    }
                    else{
                      addPost();
                      print('name: $email');
                      Navigator.pushNamed(context, PostsMain.id);
                    }
                  },
                  child: const Text(
                    'Update',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),

            ],
          ),
        ),

      ),
    );
  }
}
