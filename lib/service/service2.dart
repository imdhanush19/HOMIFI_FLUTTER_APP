import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:osapp/service/servicereturn2.dart';

class Service2 extends StatefulWidget {
  const Service2({super.key});

  @override
  State<Service2> createState() => _Service2State();
}

class _Service2State extends State<Service2> {
  List<String>docsIDs=[];


  Future getDocId() async{
    await FirebaseFirestore.instance.collection('plumbing').get().then(
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
        title:Text('PLUMBING',
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
                          title:GetService2(documentId: docsIDs[index],)
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
