import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_pro/screens/resultUserSearch.dart';



final _firestore = FirebaseFirestore.instance;
class SearchUser extends StatefulWidget {
  static const String id='search user';
  const SearchUser({Key? key}) : super(key: key);

  @override
  _LoginMainState createState() => _LoginMainState();
}

class _LoginMainState extends State<SearchUser> {
  Future<FirebaseApp>_inthialFire()async{
    FirebaseApp firebaseApp=await Firebase.initializeApp();
    return firebaseApp;
  }
  late String city;
  late int cost;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _inthialFire(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const SearchUserPage();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
class SearchUserPage extends StatefulWidget {

  const  SearchUserPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchUserPage> {
  late String hallName;

  List<Map<String, dynamic>> fetchedPostList=[];
  getData()async{
    _firestore.collection('post').where('hallName',isEqualTo:hallName  ).snapshots().listen((event){
      for (var element in event.docs) {
        final Map<String, dynamic> dataPost={
          'docId':element.id,
          'region': element.data()['region'],
          'hallName': element.data()['hallName'],
          'capacity': element.data()['capacity'],
          'cost': element.data()['cost'],
          'governorate': element.data()['governorate'],
          'details': element.data()['details'],
          'image' :element.data()['image'],
          'email':element.data()['email'],
        };
        setState(() {
          fetchedPostList.add(dataPost);
        });

      }

    } );
  }
  List<Map<String, dynamic>> fetchedReservationList=[];
  void fetchReservation()
  {
    _firestore.collection('Approved').snapshots().listen((event) {
      for (var element in event.docs) {
        final Map<String, dynamic> dataPost={
          'username': element.data()['username'],
          'docID': element.data()['docID'],
          'IsApprove': element.data()['IsApprove'],
          'weddingDays': element.data()['weddingDays'],
          'email': element.data()['email'],
          'hallName': element.data()['hallName'],
        };
        setState(() {
          fetchedReservationList.add(dataPost);
        });

      }
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchReservation();
  }



  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,

        ),
        drawer: const Drawer(),
        body:ListView(children: [



          Container(
            margin: const EdgeInsets.only(top: 30,left: 30,right: 30),
            child: TextFormField(
              decoration: const InputDecoration(
                  labelText: "Hall Name",
                  icon: Icon(Icons.opacity_sharp),
                  border: OutlineInputBorder()
              ),
              onChanged: (value)
              {
                hallName=value;
              },
              maxLines: 1,
              autofocus: false,
              keyboardType: TextInputType.text,
            ),

          ),


          Container(
            margin: const EdgeInsets.only(top: 30,left: 30,right: 30),
            child: TextButton.icon(
            onLongPress: (){
              setState(() {
                getData();
              });
            },
              onPressed: () {


                Navigator.push(context, MaterialPageRoute(builder: (context)=>ViweUserSearch(fetchedPostList: fetchedPostList, fetchedReservationList: fetchedReservationList,)));

              },
              icon: const Icon(Icons.search),
              label: const Text('search'),
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
