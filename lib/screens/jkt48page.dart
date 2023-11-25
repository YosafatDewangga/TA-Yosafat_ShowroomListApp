import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ta_yosafat/screens/navigation_bar.dart';
import 'package:ta_yosafat/screens/campuran.dart';
import 'package:ta_yosafat/screens/detailscreen.dart';
import 'package:ta_yosafat/screens/profile.dart';

class MemberJKT {
  final int id;
  final String name;
  Images image_url;
  final String description;
  final int follower_num;


  MemberJKT({required this.id, required this.name, required this.image_url, required this.description, required this.follower_num});

  factory MemberJKT.fromJson(Map<String, dynamic> json) {
    return MemberJKT(
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

class MemberListPage extends StatefulWidget {
  @override
  _MemberListPageState createState() => _MemberListPageState();
}

class _MemberListPageState extends State<MemberListPage> {
  late Future<List<MemberJKT>> memberList;

  @override
  void initState() {
    super.initState();
    memberList = fetchMemberList();
  }

  Future<List<MemberJKT>> fetchMemberList() async {
    final response = await http.get(
        Uri.parse('https://campaign.showroom-live.com/akb48_sr/data/room_status_list.json'));

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(utf8.decode(response.bodyBytes)) as List;
      return jsonResponse.map((member) => MemberJKT.fromJson(member)).toList();
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
            List<MemberJKT> members = snapshot.data as List<MemberJKT>;
            return ListView.builder(
              itemCount: members.length,
              itemBuilder: (context, index) {
                if (members[index].name.toLowerCase().contains('jkt48')) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(member: members[index]),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(members[index].image_url.image_url),
                      ),
                      title: Text(members[index].name),
                      subtitle: Text('ID: ${members[index].id}'),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            );
          }
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MemberlistPage()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MemberListPage()),
            );
          } 
          else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          }
          else {
            // Handle navigation item taps for other indexes if needed
          }
        },
      ),
    );
  }
}


