import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_pro/screens/show_reserve.dart';


import '../constants.dart';
final _firestore = FirebaseFirestore.instance;
final  FirebaseAuth auth = FirebaseAuth.instance;
class MangeMain extends StatefulWidget {
  static const String id='manage_hall';
  const MangeMain({Key? key}) : super(key: key);

  @override
  _LoginMainState createState() => _LoginMainState();
}

class _LoginMainState extends State<MangeMain> {
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
            return const ManageHall();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class ManageHall extends StatefulWidget {
  const ManageHall({Key? key}) : super(key: key);

  @override
  _ManageHallState createState() => _ManageHallState();
}

class _ManageHallState extends State<ManageHall> {
  List<Map<String, dynamic>> fetchedPReserveList=[];
  void fetchReservePost()
  {
    _firestore.collection('user_details').snapshots().listen((event) {
      for (var element in event.docs) {
        final Map<String, dynamic> dataPost={
          'docID': element.data()['docID'],
          'username': element.data()['username'],
          'email': element.data()['email'],
          'phone': element.data()['phone'],
          'weddingDays': element.data()['weddingDays'],
        };

        setState(() {
          fetchedPReserveList.add(dataPost);
        });
      }
    });
  }
  List<Map<String, dynamic>> fetchedPostList=[];
  void fetchPost()
  {
    _firestore.collection('post').snapshots().listen((event) {
      for (var element in event.docs) {
        final Map<String, dynamic> dataPost={
          'docId':element.id,
          'hallName': element.data()['hallName'],
          'image' :element.data()['image'],
          'email':element.data()['email'],
        };

        setState(() {
          fetchedPostList.add(dataPost);
        });
      }
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchPost();
    fetchReservePost();

  }
  Widget _buildItemPost( BuildContext context, int index)
  { final User? user= auth.currentUser;
  if(fetchedPostList[index]['email']==(user?.email).toString()) {
    return Column(
      children: [
       Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 30,
        margin: const EdgeInsets.only(left: 5, right: 3,top: 5 ),
        child: InkWell(
          splashColor: Colors.white,

          onTap: ()
          {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowReserve(fetchedPReserveList: fetchedPReserveList,index: fetchedPostList[index]['docId'], hallName: fetchedPostList[index]['hallName'], )));

           // Navigator.push(context, MaterialPageRoute(builder: (context)=>EXP(fetchedPostList:fetchedPostList, i: index,) ))    ;
          },
          child: Column(
            children: [
              Row(
                children: [
                  Image.network(fetchedPostList[index]['image'],width: 170,height: 170, ),
                  const SizedBox(
                    width: 30,
                  ),
                  Column(
                    children:  [
                      Text( fetchedPostList[index]['hallName'],style: kSendButtonTextStyle),
                      const Text(' tap to more details'),
                    ],
                  ),


                ],
              ),
            ],
          ),
        ),
      ),
     /*   Row(
          children: [
            TextButton(onPressed: (){

              //Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdatePost(postId:fetchedPostList['docId'][index]  )))    ;

            },
                child: const Text('Edit')),
            TextButton(onPressed: (){

            },
                child: const Text('Remove')),
          ],
        ),*/
      ],
    );

  }

  return Container();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,

      ),
      drawer: const Drawer(),
      body: Stack(
          children: [



            StreamBuilder(
                stream: _firestore.collection('post').snapshots(),
                builder: (context ,snapshot)
                {
                  if(snapshot.hasError) {
                    return const Text('no post add');
                  }
                  if(snapshot.connectionState==ConnectionState.waiting) {
                    return const Center(child:  Text('waiting for connection !',style: kSendButtonTextStyle,));
                  }
                  if( snapshot.hasData)
                  {
                    return ListView.builder(
                      //scrollDirection: Axis.horizontal,
                      itemBuilder: _buildItemPost,
                      itemCount: fetchedPostList.length,
                    );

                  }
                  return const Text('loading');
                }

            ),



          ]),
    );
  }
}
