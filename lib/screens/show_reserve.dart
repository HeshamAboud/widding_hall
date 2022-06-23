import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';



final _firestore = FirebaseFirestore.instance;
class ShowReserve extends StatelessWidget {
 final List<Map<String, dynamic>> fetchedPReserveList;
 final String index;
 final String hallName;

  const ShowReserve({Key? key, required this.fetchedPReserveList, required this.index, required this.hallName}) : super(key: key);

  Widget _buildItemcomment( BuildContext context, int i)
 {

   if(fetchedPReserveList[i]['docID']==index) {
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
                     Text(hallName,style: const TextStyle(fontWeight:FontWeight.bold),),
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

                   const Text('Phone '),
                   const SizedBox(width: 5,),
                   Text(fetchedPReserveList[i]['phone'],style: const TextStyle(fontWeight:FontWeight.bold),),
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
                   MaterialButton(
                     color: Colors.pinkAccent, // background
                     textColor: Colors.black,
                     onPressed: (){

                     _firestore.collection('Approved').add(
                         {
                           'username':fetchedPReserveList[i]['username'],
                           'IsApprove':'Accept',
                           'weddingDays':fetchedPReserveList[i]['weddingDays'],
                           'docID':index,
                           'email':fetchedPReserveList[i]['email'],
                           'hallName':hallName,
                         });
                   }, child: const Text('Accept'),

                   ),
                   const SizedBox(width: 20,),
                   MaterialButton( // background
                       color: Colors.pinkAccent, // background
                       textColor: Colors.black,
                       onPressed: (){

                     _firestore.collection('Approved').add(
                         {
                           'username':fetchedPReserveList[i]['username'],
                           'IsApprove':'Refuse',
                           'weddingDays':fetchedPReserveList[i]['weddingDays'],
                           'docID':index,
                           'email':fetchedPReserveList[i]['email'],
                           'hallName':hallName,
                         });
                   }, child: const Text('Refuse')),
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
