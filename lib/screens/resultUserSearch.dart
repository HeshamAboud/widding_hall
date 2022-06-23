import 'package:flutter/material.dart';
import 'package:new_pro/screens/myReservation.dart';
import '../constants.dart';

class ViweUserSearch extends StatelessWidget {
  final  List<Map<String, dynamic>> fetchedPostList;
  List<Map<String, dynamic>> fetchedReservationList=[];
   ViweUserSearch({Key? key, required this.fetchedPostList,required this.fetchedReservationList}) : super(key: key);
  Widget _buildItemPost( BuildContext context, int index)
  {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 15,
      margin: const EdgeInsets.only(left: 5, right: 3,top: 5 ),
      child: InkWell(
        splashColor: Colors.white,

        onTap: ()
        {
        print (fetchedReservationList[index]['hallName']);
          Navigator.push(context, MaterialPageRoute(builder: (context)=>MyReserve(fetchedPReserveList: fetchedReservationList, inde: fetchedPostList[index]['docId'],) ))    ;
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
                    const Text(' Show My Reservation'),
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
