import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:osapp/service/servicereturn5.dart';

class Service5 extends StatefulWidget {
  const Service5({super.key});

  @override
  State<Service5> createState() => _Service5State();
}

class _Service5State extends State<Service5> {
  List<String>docsIDs=[];


  Future getDocId() async{
    await FirebaseFirestore.instance.collection('carpentry').get().then(
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
        title:Text('CARPENTRY',
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
                          title:GetService5(documentId: docsIDs[index],)
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
