import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:foldable_sidebar/foldable_sidebar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:SalemEurope/Widgets/TextBox.dart';
import 'dart:io';
//import 'package:sampleproject/customAppBar.dart';
//import 'package:sampleproject/customdrawer.dart';
//import 'package:sampleproject/drawers.dart';

import '../constant.dart';

class Events extends StatefulWidget {
  Events({Key key}) : super(key: key);

  @override
  _EventsState createState() => _EventsState();
}

enum AppState {
  free,
  picked,
  cropped,
}

class _EventsState extends State<Events> {
  TextEditingController _eventTitle = TextEditingController();
  TextEditingController _transportInformation = TextEditingController();
  String _date;
  String _startTime;
  String _endTime;
  AppState state;
  File imageFile;
  TextEditingController _fileName = TextEditingController();

  bool dateInitial = true;
  bool startTimeInitial = true;
  bool endTimeInitial = true;

  FSBStatus drawerStatus;

  final decor = BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
      boxShadow: [
        BoxShadow(offset: Offset(0, 2), blurRadius: 5, color: Color(0xFF6A1B9A))
      ]);

  final data = CupertinoThemeData(
      textTheme: CupertinoTextThemeData(
    dateTimePickerTextStyle: TextStyle(fontSize: 20, color: Colors.white),
  ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF93328f),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height >= 775.0
              ? MediaQuery.of(context).size.height
              : 775.0,
          padding: EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                  height: 60,
                  padding: EdgeInsets.only(left: 30.0),
                  decoration: decor,
                  child: TextBox("Enter an Event Title", 1, _eventTitle)),
              SizedBox(height: 30),
              Container(
                  height: 100,
                  padding: EdgeInsets.all(10),
                  decoration: decor,
                  child: TextBox(
                      "Enter Transport Information", 3, _transportInformation)),
              SizedBox(
                height: 30.0,
              ),
              Row(children: <Widget>[
                SizedBox(height: 20),
                Container(
                    decoration: decor,
                    height: 50,
                    width: 180,
                    child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10),
                        ),
                        elevation: 6.0,
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext builder) {
                                return Container(
                                  height: MediaQuery.of(context)
                                          .copyWith()
                                          .size
                                          .height /
                                      5,
                                  child: CupertinoTheme(
                                    data: data,
                                    child: CupertinoDatePicker(
                                      initialDateTime: DateTime.now(),
                                      backgroundColor: Color(0xFF6A1B9A),
                                      mode: CupertinoDatePickerMode.date,
                                      onDateTimeChanged: (date) {
                                        setState(() {
                                          _date =
                                              '${date.year} : ${date.month} : ${date.day}';
                                          dateInitial = false;
                                        });
                                      },
                                    ),
                                  ),
                                );
                              });
                        },
                        child: Container(
                            child: Row(children: <Widget>[
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.date_range,
                            size: 25.0,
                            color: Color(0xFFefba07),
                          ),
                          Text(
                            dateInitial ? "Event Date" : _date,
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                              color: Color(0xFF6A1B9A),
                              fontStyle: FontStyle.normal,
                            )),
                          ),
                        ])))),
                SizedBox(width: 30),
                Column(children: <Widget>[
                  SizedBox(height: 30),
                  Container(
                      decoration: decor,
                      height: 50,
                      width: 160,
                      child: RaisedButton(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            // side: BorderSide(color: Colors.black),
                          ),
                          elevation: 6.0,
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext builder) {
                                  return Container(
                                    height: MediaQuery.of(context)
                                            .copyWith()
                                            .size
                                            .height /
                                        5,
                                    child: CupertinoTheme(
                                      data: data,
                                      child: CupertinoDatePicker(
                                        use24hFormat: true,
                                        initialDateTime: DateTime(2020, 01, 01),
                                        minuteInterval: 30,
                                        backgroundColor: Color(0xFF6A1B9A),
                                        mode: CupertinoDatePickerMode.time,
                                        onDateTimeChanged: (startTime) {
                                          setState(() {
                                            _startTime =
                                                '${startTime.hour} : ${startTime.minute}';
                                            startTimeInitial = false;
                                          });
                                        },
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: Container(
                              child: Row(children: <Widget>[
                            Icon(
                              Icons.access_time,
                              size: 25.0,
                              color: Color(0xFFefba07),
                            ),
                            Text(
                              startTimeInitial ? "Start Time" : _startTime,
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                                color: Color(0xFF6A1B9A),
                                fontStyle: FontStyle.normal,
                              )),
                            ),
                          ])))),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                      decoration: decor,
                      height: 50,
                      width: 160,
                      child: RaisedButton(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            // side: BorderSide(color: Colors.black),
                          ),
                          elevation: 6.0,
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext builder) {
                                  return Container(
                                    height: MediaQuery.of(context)
                                            .copyWith()
                                            .size
                                            .height /
                                        5,
                                    child: CupertinoTheme(
                                      data: data,
                                      child: CupertinoDatePicker(
                                        use24hFormat: true,
                                        initialDateTime: DateTime(2020, 01, 01),
                                        minuteInterval: 30,
                                        backgroundColor: Color(0xFF6A1B9A),
                                        mode: CupertinoDatePickerMode.time,
                                        onDateTimeChanged: (endTime) {
                                          setState(() {
                                            _endTime =
                                                '${endTime.hour} : ${endTime.minute}';
                                            endTimeInitial = false;
                                          });
                                        },
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: Container(
                              child: Row(children: <Widget>[
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.access_time,
                              size: 25,
                              color: Color(0xFFefba07),
                            ),
                            Text(
                              endTimeInitial ? "End Time" : _endTime,
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                                color: Color(0xFF6A1B9A),
                                fontStyle: FontStyle.normal,
                              )),
                            ),
                          ]))))
                ])
              ]),
              SizedBox(
                height: 30,
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height >= 775.0
                      ? MediaQuery.of(context).size.height
                      : 775.0,
                  padding: EdgeInsets.all(10),
                  child: Column(children: <Widget>[
                    Container(
                        height: 60,
                        width: 350,
                        padding: EdgeInsets.all(10),
                        decoration: decor,
                        child: TextBox("File Name", 1, _fileName)),
                    SizedBox(
                      height: 40,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _pickImage();
                        });
                      },
                      child: Container(
                        height: 350,
                        width: 350,
                        decoration: decor,
                        child: Center(
                            child: imageFile != null
                                ? Image.file(imageFile)
                                : const Text(
                                    'Tap here to add image',
                                    style: TextStyle(
                                      // fontWeight: FontWeight.w800,
                                      fontSize: 20,
                                      color: Color(0xFF6A1B9A),
                                      fontStyle: FontStyle.normal,
                                    ),
                                  )),
                      ),
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton.extended(
                        backgroundColor: Color(0xFF6A1B9A),
                        label: Text('Save', style: TextStyle(color: textcolor)),
                        onPressed: () {
                          _save();
                        },
                        icon: _buildButtonIcon(),
                      ),
                    ),
                  ])),
              Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    backgroundColor: kbuttoncolor,
                    onPressed: () {
                      _handleEvent();
                    },
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 40,
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleEvent() async {
    // FirebaseFirestore.instance.collection('events').doc("test").set({
    //   'eventTitle': _eventTitle.text,
    //   'transportInformation': _transportInformation.text,
    //   'eventDate': _date,
    //   'startTime': _startTime,
    //   'endTime': _endTime,
    // });

    FirebaseFirestore.instance.collection('events').add(<String, dynamic>{
      'eventTitle': _eventTitle.text,
      'transportInformation': _transportInformation.text,
      'eventDate': _date,
      'startTime': _startTime,
      'endTime': _endTime
    });

    var name = _eventTitle.text.replaceAll(new RegExp(r"\s+"), "");

    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Events/$name.jpg');

    final metadata =
        firebase_storage.SettableMetadata(contentType: 'image/jpeg');

    ref.putFile(imageFile, metadata);
  }

  Widget _buildButtonIcon() {
    if (state == AppState.free)
      return Icon(
        MdiIcons.contentSave,
        color: iconbackground,
      );
    else if (state == AppState.picked)
      return Icon(Icons.thumb_up, color: Colors.white);
    else if (state == AppState.cropped)
      return Icon(Icons.clear, color: Colors.white);
    else
      return Container();
  }

  Future<Null> _pickImage() async {
    imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      setState(() {
        state = AppState.picked;
      });
    }
  }

  void _save() {
    String name = _fileName.text;
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('images/users/qUvDfBIfZXfOaXj8Svmx8pc9JDK2/$name.jpg');

    final metadata =
        firebase_storage.SettableMetadata(contentType: 'image/jpeg');

    ref.putFile(imageFile, metadata);

    // Navigator.push(context,MaterialPageRoute(builder: (context) => LoginPage()),
    //);
  }
}
