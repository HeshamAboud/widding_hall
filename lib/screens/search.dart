import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_pro/screens/viwe_search.dart';


final _firestore = FirebaseFirestore.instance;
class Search extends StatefulWidget {
  static const String id='search';
  const Search({Key? key}) : super(key: key);

  @override
  _LoginMainState createState() => _LoginMainState();
}

class _LoginMainState extends State<Search> {
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
            return const SearchPage();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
class SearchPage extends StatefulWidget {

 const  SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late String city;
  late int c;
  List<Map<String, dynamic>> fetchedPostList=[];
  getData()async{
  _firestore.collection('post').where('governorate',isEqualTo:city  ).where('cost',isLessThanOrEqualTo: c).snapshots().listen((event){
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

  List<Map<String, dynamic>> fetchedCommentList=[];
  void fetchComment()
  {
    _firestore.collection('comment').snapshots().listen((event) {
      for (var element in event.docs) {
        final Map<String, dynamic> dataPost={
          'comment': element.data()['comment'],
          'id': element.data()['id'],


        };
        setState(() {
          fetchedCommentList.add(dataPost);
        });

      }
    });

  }
  List<Map<String, dynamic>> fetchedList=[];
  void fetchReservation()
  {
    _firestore.collection('genral_comment').snapshots().listen((event) {
      for (var element in event.docs) {
        final Map<String, dynamic> dataPost={
          'general': element.data()['general '],
          'CommentId':element.id,



        };
        setState(() {
          fetchedList.add(dataPost);
        });

      }
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchComment();
    getData();
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
                  labelText: "city",
                  icon: Icon(Icons.opacity_sharp),
                  border: OutlineInputBorder()
              ),
              onChanged: (value)
              {
                city=value;
              },
              maxLines: 1,
              autofocus: false,
              keyboardType: TextInputType.text,
            ),

          ),

          Container(
            margin: const EdgeInsets.only(top: 30,left: 30,right: 30),
            child: TextFormField(


              decoration: const InputDecoration(
                  labelText: "Cost",
                  icon:  Icon(Icons.attach_money_outlined),
                  border:  OutlineInputBorder(),

              ),
              onChanged: (value)
              {
                c=int.parse(value);
              },
              maxLines: 1,
              autofocus: false,
              keyboardType: TextInputType.number,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 30,left: 30,right: 30),
            child: TextButton.icon(
              onLongPress: ()
              {
                setState(() {
                  getData();
                });

              },
              onPressed: () {
                // print(fetchedPostList[0]['hallName']);
                getData();
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ViweSearch(fetchedPostList: fetchedPostList, fetchedCommentList: fetchedCommentList,fetchedList: fetchedList,) ))    ;

              },

              icon: const Icon(Icons.search),
              label: const Text('search'),
              style:ElevatedButton.styleFrom(shadowColor: Colors.black54,elevation: 50,padding: const EdgeInsets.all(20)
                  ,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),primary: Colors.pink) ,
            ),

          ),

        ],
        ),

      ),

    );
  }
}
