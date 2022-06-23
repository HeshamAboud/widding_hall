import 'package:flutter/material.dart';
import 'package:new_pro/screens/rate.dart';
import 'package:new_pro/screens/serve.dart';
import 'package:new_pro/screens/show_comment.dart';


import 'add_comment.dart';
class ViweSearch extends StatelessWidget {
  final  List<Map<String, dynamic>> fetchedPostList;
  final  List<Map<String, dynamic>> fetchedCommentList;
  List<Map<String, dynamic>> fetchedList;
  ViweSearch({Key? key, required this.fetchedPostList, required this.fetchedCommentList,required this.fetchedList}) : super(key: key);
  Widget _buildItemPost( BuildContext context, int index)
  {
    return SingleChildScrollView(
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
                  child:  Image.network(fetchedPostList[index]['image'], ),

                ), ],
            ),
            Text(fetchedPostList[index]['hallName'],style: const TextStyle(fontSize: 30,fontWeight:FontWeight.bold,),),
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
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    IconButton(onPressed: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Comment(postId: fetchedPostList[index]['docId'],)));

                    }, icon: const Icon(Icons.comment),
                      color: Colors.pinkAccent,
                    ),
                    const Text("Add comment",style: TextStyle(fontSize:15),),
                    //const SizedBox(width: 5,),
                    IconButton(onPressed: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowComment(fetchedCommentList: fetchedCommentList, i: fetchedPostList[index]['docId'],)));

                    }, icon: const Icon(Icons.comment),
                      color: Colors.pinkAccent,
                    ),
                    const Text("Show comment",style: TextStyle(fontSize:15),),



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
              child: Text(fetchedPostList[index]['details'],style: const TextStyle(fontSize: 20,),),
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
                    Text(fetchedPostList[index]['governorate'])
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
                    Text(fetchedPostList[index]['capacity'].toString() )
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
                    Text(fetchedPostList[index]['cost'].toString()),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
                const Divider(
                  height: 50,
                  thickness: 1,
                  color: Colors.black12,
                ),
                Row(
                  children: [
                    IconButton(onPressed: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ServeHall( idDoc: fetchedPostList[index]['docId'])));

                    },
                      icon: const Icon(Icons.phone,size: 35,),
                      color: Colors.pinkAccent,
                    ),
                    const Text("Contact",style: TextStyle(fontSize:15),),
                  ],
                ),
                const Divider(
                  height: 50,
                  thickness: 1,
                  color: Colors.black12,
                ),
                Row(
                  children: [
                    IconButton(onPressed: ()
                    {

                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Rate( i: fetchedPostList[index]['docId'], fetchedList: fetchedList,)));

                    },
                      icon: const Icon(Icons.star_rate,size: 35,),
                      color: Colors.pinkAccent,
                    ),
                    const Text("show rate ",style: TextStyle(fontSize:15),),
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
      ),
      drawer:const Drawer(),
      body: ListView.builder(itemBuilder: _buildItemPost,
        itemCount: fetchedPostList.length,
      ),
    );
  }
}
