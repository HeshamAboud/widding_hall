


import 'package:flutter/material.dart';
import 'package:new_pro/screens/serve.dart';

import 'add_comment.dart';
class EXP extends StatelessWidget {
  final  List<Map<String, dynamic>> fetchedPostList;
  final int i;
  List<Map<String, dynamic>> fetchedReservedList;
   EXP({ Key ?key, required this.fetchedPostList,required this.i,required this.fetchedReservedList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(backgroundColor: Colors.pink,
        title:  Text(fetchedPostList[1]['hallName'],style: const TextStyle(fontSize: 30,fontWeight:FontWeight.bold,),),
      ),
      drawer: const Drawer(),
      body:SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.white,
          ),
          alignment: Alignment.center,
          child:Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child:  Image.network(fetchedPostList[i]['image'], ),

                  ), ],
              ),
              Text(fetchedPostList[i]['hallName'],style: const TextStyle(fontSize: 30,fontWeight:FontWeight.bold,),),
              const Divider(
                height: 25,
                thickness: 1,
                color: Colors.black12,
              ),

              Container(
                color: Colors.pink[50],
                width: double.infinity,
                height: 75,
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      IconButton(onPressed: ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Comment(postId: fetchedPostList[i]['docId'],)));

                      }
                        , icon: const Icon(Icons.comment),
                        color: Colors.pinkAccent,
                      ),
                      const Text("Add comment",style: TextStyle(fontSize:15),),
                      const SizedBox(width: 15,),

                      IconButton(onPressed: ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ServeHall( idDoc: fetchedPostList[i]['docId'])));

                      },
                        icon: const Icon(Icons.phone,size: 35,),
                        color: Colors.pinkAccent,
                      ),

                      const Text("Contact",style: TextStyle(fontSize:15),),
                    ],
                  ),
                ),
              ),
              const Divider(
                height: 25,
                thickness: 1,
                color: Colors.black12,
              ),

              Container(
                width: 500,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white10,
                  border: Border.all(
                    color: Colors.pinkAccent,

                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(fetchedPostList[i]['details'],style: const TextStyle(fontSize: 20,),),
              ),
              const Divider(
                height: 50,
                thickness: 1,
                color: Colors.black12,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.location_on,color: Colors.pinkAccent,size: 30,),
                      const SizedBox(width: 5,),
                      Text(fetchedPostList[i]['governorate'])
                    ],
                  ),
                  const Divider(
                    height: 50,
                    thickness: 1,
                    color: Colors.black12,
                  ),
                  Row(
                    children: [

                      const Icon( Icons.reduce_capacity,color: Colors.pinkAccent,size: 30,),
                      const SizedBox(width: 5,),
                      Text(fetchedPostList[i]['capacity'].toString())
                    ],
                  ),
                  const Divider(
                    height: 50,
                    thickness: 1,
                    color: Colors.black12,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.attach_money,color: Colors.pinkAccent,size: 30,),
                      const SizedBox(width: 3,),
                      Text(fetchedPostList[i]['cost'].toString()),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),

        ),
      ),

    ) ;
  }
}
