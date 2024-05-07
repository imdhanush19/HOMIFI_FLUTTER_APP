

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:osapp/service/servicereturn3.dart';

class Service3 extends StatefulWidget {
  const Service3({super.key});

  @override
  State<Service3> createState() => _Service3State();
}

class _Service3State extends State<Service3> {
  List<String>docsIDs=[];


  Future getDocId() async{
    await FirebaseFirestore.instance.collection('electrician').get().then(
          (snapshot)=>snapshot.docs.forEach((element) {
        print(element.reference);
        docsIDs.add(element.reference.id);
      },
      ),
    );
  }

  @override
  void intiState(){
    getDocId();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title:Text('ELECTRICIAN',
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
                          title:GetService3(documentId: docsIDs[index],)
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
