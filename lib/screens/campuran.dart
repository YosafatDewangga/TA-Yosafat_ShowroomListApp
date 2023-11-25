import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ta_yosafat/screens/navigation_bar.dart';
import 'package:ta_yosafat/screens/jkt48page.dart';
import 'package:ta_yosafat/screens/detailscreen.dart';
import 'package:ta_yosafat/screens/profile.dart';
class MemberAKB {
   final int id;
  final String name;
  Images image_url;
 final String description;
  final int follower_num;


  MemberAKB({required this.id, required this.name, required this.image_url, required this.description, required this.follower_num});


  factory MemberAKB.fromJson(Map<String, dynamic> json) {
    return MemberAKB(
      id: json['id'],
      name: json['name'],
      image_url: Images.fromJson(json),
      description: json['description'],
      follower_num: json['follower_num'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image_url': image_url,
        'description' : description,
        'follower_num' : follower_num,
      };
}

class Images {
  final image_url;
  Images({required this.image_url});
  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
      image_url: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() => {
        'image_url': image_url.toJson(),
      };
}

class MemberlistPage extends StatefulWidget {
  @override
  _MemberlistPageState createState() => _MemberlistPageState();
}

class _MemberlistPageState extends State<MemberlistPage> {
  late Future<List<MemberAKB>> memberList;

  @override
  void initState() {
    super.initState();
    memberList = fetchMemberList();
  }

  Future<List<MemberAKB>> fetchMemberList() async {
    final response = await http.get(Uri.parse(
        'https://campaign.showroom-live.com/akb48_sr/data/room_status_list.json'));

    if (response.statusCode == 200) {
      var jsonResponse =
          json.decode(utf8.decode(response.bodyBytes)) as List;
      return jsonResponse
          .map((member1) => MemberAKB.fromJson(member1))
          .toList();
    } else {
      throw Exception('Failed to load member list');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Member List'),
      ),
      body: FutureBuilder(
        future: memberList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<MemberAKB> members = snapshot.data as List<MemberAKB>;
            return ListView.builder(
              itemCount: members.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            detailScreen(member: members[index]),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 40,
                      backgroundImage:
                          NetworkImage(members[index].image_url.image_url),
                    ),
                    title: Text(members[index].name),
                    subtitle: Text('ID: ${members[index].id}'),
                  ),
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            // Navigate to AKB48Page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MemberlistPage()),
            );
          } else if (index == 1) {
            // Navigate to JKT48Page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MemberListPage()),
            );
          } 
           else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),);}
          
          else {
            // Handle navigation item taps for other indexes if needed
          }
        },
      ),
    );
  }
}
