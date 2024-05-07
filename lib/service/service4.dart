import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:osapp/service/servicereturn4.dart';

class Service4 extends StatefulWidget {
  const Service4({super.key});

  @override
  State<Service4> createState() => _Service4State();
}

class _Service4State extends State<Service4> {
  List<String>docsIDs=[];


  Future getDocId() async{
    await FirebaseFirestore.instance.collection("beautyandspa").get().then(
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
        title:Text('BEAUTY & SPA',
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
                          title:GetService4(documentId: docsIDs[index],)
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
