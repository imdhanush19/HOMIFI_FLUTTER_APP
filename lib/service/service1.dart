import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:osapp/service/servicereturn1.dart';

class Service1 extends StatefulWidget {
  const Service1({super.key});

  @override
  State<Service1> createState() => _Service1State();
}

class _Service1State extends State<Service1> {
  List<String>docsIDs=[];




  Future getDocId() async{
    await FirebaseFirestore.instance.collection('cleaning').get().then(
        (snapshot)=>snapshot.docs.forEach((element) {
          print(element.reference);
          docsIDs.add(element.reference.id);
        },
        ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title:Text('CLEANING',
        style:TextStyle(
          fontWeight: FontWeight.bold,

        ),


        ),
        centerTitle:true,
        backgroundColor: Colors.green,
      ),
      body:Column(
        children:[
          Expanded(
            child: FutureBuilder(
              future: getDocId(),
              builder: (context, snapshot) {
                return ListView.builder(
                  itemCount:docsIDs.length,
                  itemBuilder:(context,index){
                    return ListTile(
                      title:GetService1(documentId: docsIDs[index],)
                    );
                  }
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

