

import 'package:flutter/material.dart';




class MyReserve extends StatelessWidget {
  final List<Map<String, dynamic>> fetchedPReserveList;
  final String inde;


  const MyReserve({Key? key, required this.fetchedPReserveList, required this.inde}) : super(key: key);

  Widget _buildItemcomment( BuildContext context, int i)
  {
    if(fetchedPReserveList[i]['docID']==inde) {
      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 4,
        color: Colors.pink[200],
        margin: const EdgeInsets.only(left: 10, right: 10,top: 15 ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            alignment: Alignment.topLeft,
            height:180,
            width: 480,
            child: Column(
              children: [
                Row(

                  children: [
                    const Text('Hall Name :'),
                    const SizedBox(width: 5,),
                    Text(fetchedPReserveList[i]['hallName'],style: const TextStyle(fontWeight:FontWeight.bold),),
                  ],
                ),
                Row(
                  children: [

                    const Text('Name '),
                    const SizedBox(width: 5,),
                    Text(fetchedPReserveList[i]['username'],style: const TextStyle(fontWeight:FontWeight.bold),),
                  ],
                ),

                const SizedBox(height: 7,),
                Row(
                  children: [
                    const Text('email :'),
                    const SizedBox(width: 5,),
                    Text(fetchedPReserveList[i]['email'],style: const TextStyle(fontWeight:FontWeight.bold),),
                  ],
                ),
                const SizedBox(height: 7,),
                Row(
                  children: [
                    const Text('Wedding Days :'),
                    const SizedBox(width: 5,),
                    Text(fetchedPReserveList[i]['weddingDays'],style: const TextStyle(fontWeight:FontWeight.bold),),
                  ],
                ),
                const SizedBox(height: 7,),
                Row(
                  children: [
                    const Text('Approved:'),
                    const SizedBox(width: 5,),
                    Text(fetchedPReserveList[i]['IsApprove'],style: const TextStyle(fontWeight:FontWeight.bold),),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }



    return Container();


  }
/* void addPost()
 {
   _firestore.collection('Approved').add(
       {
         'username':fetchedPReserveList[i]['username'],

       });


 }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,

      ),
      drawer: const Drawer(),
      body: ListView.builder(itemBuilder: _buildItemcomment,
        itemCount: fetchedPReserveList.length,
      ),

    );
  }
}
