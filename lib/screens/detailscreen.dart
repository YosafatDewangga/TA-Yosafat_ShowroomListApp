
import 'package:flutter/material.dart';
import 'package:ta_yosafat/screens/jkt48page.dart';
import 'package:ta_yosafat/screens/campuran.dart';

class DetailScreen extends StatelessWidget {
  final MemberJKT member;
  
  DetailScreen({required this.member});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(member.image_url.image_url),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
               
              ],
            ),
            SizedBox(height: 20),
            Text(
              member.name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '@${member.name}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                member.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
         
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}



class detailScreen extends StatelessWidget {
  final MemberAKB member;
  
  detailScreen({required this.member});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(member.image_url.image_url),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
               
              ],
            ),
            SizedBox(height: 20),
            Text(
              member.name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '@${member.name}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                member.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
         
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}
