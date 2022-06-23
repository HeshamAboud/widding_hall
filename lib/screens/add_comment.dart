


import 'package:cloud_firestore/cloud_firestore.dart';

 import 'package:flutter/material.dart';
 import '../constants.dart';
 final _firestore = FirebaseFirestore.instance;
 class Comment extends StatelessWidget {
   late final String postId;
   late String comment;

  Comment(  {Key? key,required this.postId}) : super(key: key);
   void addPost()
   {
     _firestore.collection('comment').add(
       {
         'comment':comment,
         'id':postId,
       });


   }

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       body: Column(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         crossAxisAlignment: CrossAxisAlignment.stretch,
         children: <Widget>[

           const SizedBox(
             height: 20,
           ),
          Container(
             decoration: kMessageContainerDecoration,
             child: Row(
               crossAxisAlignment: CrossAxisAlignment.center,
               children: <Widget>[
                 Expanded(
                   child: TextField(
                     onChanged: (String value) {
                        print(value);
                       comment=value;
                     },
                     decoration: kMessageTextFieldDecoration,
                   ),
                 ),
                 TextButton(
                   onPressed: () {
                     if(comment.isNotEmpty)
                       {
                         addPost();
                         print(comment);
                         Navigator.of(context).pop();

                       }
                     else
                       {
                         AlertDialog(
                           title: const Text('AlertDialog Title'),
                         content: SingleChildScrollView(
                             child: ListBody(
                               children: const <Widget>[
                                 Text('add comment'),
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
                        },
                      child: const Text(
                              'Send',      style: kSendButtonTextStyle,
                         ),
                   ),
                   ]
                 ),
           ),
               ],
             ),
    );
   }
 }

