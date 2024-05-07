import 'package:flutter/material.dart';
import 'package:osapp/pages/homepage.dart';
import 'package:osapp/service/service1.dart';

import '../service/service2.dart';
import '../service/service3.dart';
import '../service/service4.dart';
import '../service/service5.dart';
import '../service/service6.dart';


class ClickEase extends StatefulWidget {
  @override
  State<ClickEase> createState() => _ClickEaseState();
}

class _ClickEaseState extends State<ClickEase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('HOMIFI',),
        backgroundColor: Colors.green,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              child: IconButton(
                icon: Icon(Icons.person),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)
                    =>HomePage(),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Explore Services',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color:Colors.white,
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              padding: EdgeInsets.all(20.0),
              children: [

                  ServiceCard(
                    title: 'Cleaning',
                    icon: Icons.cleaning_services,
                  ),
                                ServiceCard(
                  title: 'Plumbing',
                  icon: Icons.plumbing,
                ),
                ServiceCard(
                  title: 'Electrician',
                  icon: Icons.electrical_services,
                ),
                ServiceCard(
                  title: 'Beauty & Spa',
                  icon: Icons.spa,
                ),
                ServiceCard(
                  title: 'Carpentry',
                  icon: Icons.build,
                ),
                ServiceCard(
                  title: 'Painting',
                  icon: Icons.format_paint,
                ),
                // Add more service cards as needed
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const ServiceCard({
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: InkWell(
        onTap: () {
          if(title=='Cleaning'){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Service1(),
              ),
            );
          }// Add navigation logic here

          if(title=='Plumbing'){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Service2(),
              ),
            );
          }

          if(title=='Electrician'){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Service3(),
              ),
            );
          }

          if(title=='Beauty & Spa'){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Service4(),
              ),
            );
          }

          if(title=='Carpentry'){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Service5(),
              ),
            );
          }

          if(title=='Painting'){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Service6(),
              ),
            );
          }
        },
        borderRadius: BorderRadius.circular(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50.0,
              color: Colors.greenAccent,
            ),
            SizedBox(height: 10.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
