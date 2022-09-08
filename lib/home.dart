// import 'dart:html';

import 'dart:convert';

import 'package:fitness_app/display.dart';
import 'package:fitness_app/model.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home_page extends StatefulWidget {
  const Home_page({Key? key}) : super(key: key);

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  String link =
      "https://raw.githubusercontent.com/codeifitech/fitness-app/master/exercises.json";

  List<ModelData> allData = [];

  fetchData() async {
    var response = await http.get(Uri.parse(link));

    if (response.statusCode == 200) {
      print(response.body);

      var item = jsonDecode(response.body);
      print(item);

      for (var data in item["exercises"]) {
        ModelData modelDataObj = ModelData(
            id: data["id"],
            gif: data["gif"],
            title: data["title"],
            thumbnail: data["thumbnail"]);

        setState(() {
          allData.add(modelDataObj);
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black87,
          title: Text(
            "Fitness Application",
            style: TextStyle(color: Colors.white),
          )),
      body: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 15),
              child: Text(
                "Recommendations",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: allData.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(14),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Display(
                                              modelData: allData[index],
                                            )));
                              },
                              child: Image.network(
                                "${allData[index].thumbnail}",
                                height: 250,
                                width: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            bottom: 0,
                            child: Container(
                              height: 80,
                              width: 150,
                              color: Colors.black54,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 18, left: 14),
                                child: Text(
                                  "${allData[index].title}",
                                  style: TextStyle(
                                      fontSize: 23, color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 15),
              child: Text(
                "Explore More",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              child: ListView.builder(
                  itemCount: allData.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(14),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Display(
                                              modelData: allData[index],
                                            )));
                              },
                              child: Image.network(
                                "${allData[index].thumbnail}",
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Container(
                              height: 80,
                              color: Colors.black54,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 18, left: 14),
                                child: Text(
                                  "${allData[index].title}",
                                  style: TextStyle(
                                      fontSize: 23, color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
