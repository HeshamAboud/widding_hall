import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:new_pro/screens/search.dart';
import '../componant/firebase_api.dart';
import 'my_posts.dart';


final _firestore = FirebaseFirestore.instance;

class AddPostMain extends StatefulWidget {
  static const String id='hall_owner';
  const AddPostMain({Key? key}) : super(key: key);

  @override
  _LoginMainState createState() => _LoginMainState();
}

class _LoginMainState extends State<AddPostMain> {
  Future<FirebaseApp>_inthialFire()async{
    FirebaseApp firebaseApp=await Firebase.initializeApp();
    return firebaseApp;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _inthialFire(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return AddPost();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
class AddPost extends StatefulWidget {

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
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
  UploadTask? task;
  File? file;
  String? imageUrl;
 late int c;
late int ca;
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
  }


  Future uploadFile() async {
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = 'files/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    setState(() {
      imageUrl = urlDownload;
    });

    print('Download-Link: $urlDownload');
  }



  void addPost()
  {

    _firestore.collection('post').add({
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
      'image': imageUrl,

    });
  }
  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : 'No Image Selected';
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
              Container(
                height: 80,
                color: Colors.pink[100],
                width: double.infinity,
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.add_a_photo_outlined),
                      onPressed: (){
                           selectFile();
                      },
                    ),
                    const Text("Add images",style: TextStyle(fontWeight: FontWeight.bold),)


                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                fileName,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Container(
                height: 80,
                color: Colors.pink[100],
                width: double.infinity,
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.add_a_photo_outlined),
                      onPressed: (){
                      uploadFile();
                      },
                    ),
                    const Text("upload images",style: TextStyle(fontWeight: FontWeight.bold),)


                  ],
                ),
              ),
              const SizedBox(height: 20),
              task != null ? buildUploadStatus(task!) : Container(),
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
                      );
                    }
                    else{
                      addPost();
                      print('name: $email');
                      Navigator.pushNamed(context, PostsMain.id);
                    }
                  },
                  child: const Text(
                    'ADD',
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

Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
  stream: task.snapshotEvents,
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      final snap = snapshot.data!;
      final progress = snap.bytesTransferred / snap.totalBytes;
      final percentage = (progress * 100).toStringAsFixed(2);

      return Text(
        '$percentage %',
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      );
    } else {
      return Container();
    }
  },
);

