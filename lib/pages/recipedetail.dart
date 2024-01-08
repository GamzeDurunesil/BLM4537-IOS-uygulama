import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/database/database_service.dart';


class detail extends StatefulWidget {
  @override
  _detailState createState() => _detailState();
}

class _detailState extends State<detail> {
  DatabaseService _statusService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return StreamBuilder<QuerySnapshot>(
      stream: _statusService.getStatus(),
      builder: (context, snaphot) {
        return !snaphot.hasData
            ? CircularProgressIndicator()
            : ListView.builder(
                itemCount: snaphot.data!.docs.length,
                itemBuilder: (context, i) {
                  final mypost = snaphot.data!.docs[i];

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      child: Container(
                        height: size.height * .3,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(220, 220, 220, 1),
                            border: Border.all(
                                color: Color.fromRGBO(154, 82, 26, 1),
                                width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: w,
                                  height: h * .4,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(200, 200, 200, 1),
                                      borderRadius: BorderRadius.circular(30),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image:
                                              NetworkImage(mypost['image']))),
                                ),
                                Text(
                                  "${mypost['header']}",
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Color.fromRGBO(154, 82, 26, 1)),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  "${mypost['ingredients']}",
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Color.fromRGBO(154, 82, 26, 1)),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  "${mypost['description']}",
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Color.fromRGBO(154, 82, 26, 1)),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                });
      },
    );
  }
}
