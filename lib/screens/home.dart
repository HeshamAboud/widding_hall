

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_pro/screens/mange_hall.dart';
import 'package:new_pro/screens/search.dart';
import 'package:new_pro/screens/showUserReservation.dart';
import '../constants.dart';
import 'add_post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'exp.dart';
import 'login_screen.dart';
import 'my_posts.dart';
final  FirebaseAuth auth = FirebaseAuth.instance;
final  _firestore=FirebaseFirestore.instance;
class HomeMain extends StatefulWidget {
  static const String id='home';
  const HomeMain({Key? key}) : super(key: key);

  @override
  _LoginMainState createState() => _LoginMainState();
}

class _LoginMainState extends State<HomeMain> {
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
            return  const App();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);



  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {



  List<Map<String, dynamic>> fetchedPostList=[];
  void fetchPost()
  {


    _firestore.collection('post').snapshots().listen((event) {
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
    });

  }
  List<Map<String, dynamic>> fetchedReservedList=[];
  void fetchReserv()
  {
    _firestore.collection('user_details').snapshots().listen((event) {
      for (var element in event.docs) {
        final Map<String, dynamic> dataPost={
          'weddingDays': element.data()['weddingDays'],



        };
        setState(() {
          fetchedReservedList.add(dataPost);
        });

      }
    });

  }
  @override
 void initState() {
    // TODO: implement initState
    super.initState();
    fetchPost();
    fetchReserv();
    //getCurrentUser()  ;

  }
  Widget _buildItemPost( BuildContext context, int index)
  {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 30,
      margin: const EdgeInsets.only(left: 5, right: 3,top: 5 ),
      child: InkWell(
        splashColor: Colors.white,

        onTap: ()
        {

          Navigator.push(context, MaterialPageRoute(builder: (context)=>EXP(fetchedPostList:fetchedPostList, i: index,fetchedReservedList: fetchedReservedList,) ))    ;
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.pink,
        leading: null,
        actions: <Widget>[
          TextButton(
              child:

              const Text('log out',style:TextStyle(color: Colors.black,fontSize: 25,),),
              onPressed: () {
                setState(() {
                  auth.signOut();
                  Navigator.pushNamed(context, LoginMain.id);
                });
              }),

        ],
        title:TextButton.icon(

          onPressed: () {
            Navigator.pushNamed(context, Search.id);
          },
          icon: const Icon(Icons.search,color: Colors.black,),
          label: const Text('search' ,style: TextStyle(fontSize: 18, color: Colors.black),),

        ),
      ),
      drawer:  Drawer(
        child: Column(
          children: [
            AppBar(
              title:   const Text('My Account' , style: TextStyle(fontSize: 18, fontWeight: FontWeight.w100),),
              backgroundColor: Colors.pinkAccent,
            ),
            const CircleAvatar(
              maxRadius: 60,
              backgroundImage: AssetImage('image/wadding.png'),
            ),
            ListTile(

              title: const Text('Find A Wadding Hall'),
              onTap: () {
               Navigator.pushNamed(context, PostsMain.id);
              },

            ),
            ListTile(

              title: const Text('Search'),
              onTap: () {
                Navigator.pushNamed(context, Search.id);

              },

            ),
            ListTile(

              title: const Text('Add Post'),
              onTap: () async{

                  final User? user= auth.currentUser;
                if(user!=null)
                {
                  print(user.email);
                  Navigator.pushNamed(context, AddPostMain.id);
                }
                else{

                  Navigator.pushNamed(context, LoginMain.id);


                }

              //  Navigator.pushNamed(context, AddPost.id);

              },
            ),
            ListTile(

              title: const Text('Log IN'),
              onTap: () {
                Navigator.pushNamed(context, LoginMain.id);
              },

            ),
            ListTile(

              title: const Text('Manage Your hall'),
              onTap: () {

                Navigator.pushNamed(context, MangeMain.id);

              },

            ),
            ListTile(

              title: const Text('Show My Reservation'),
              onTap: () {
                Navigator.pushNamed(context, SearchUser.id);

              },

            ),
          ],
        ),
      ),
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
