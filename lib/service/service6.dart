import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:osapp/service/servicereturn6.dart';

class Service6 extends StatefulWidget {
  const Service6({super.key});

  @override
  State<Service6> createState() => _Service6State();
}

class _Service6State extends State<Service6> {
  List<String>docsIDs=[];


  Future getDocId() async{
    await FirebaseFirestore.instance.collection('painting').get().then(
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
        title:Text('PAINTING',
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
                          title:GetService6(documentId: docsIDs[index],)
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
