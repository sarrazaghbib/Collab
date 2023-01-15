import 'package:flutter/material.dart';

class Event {
  String title;
  String description;
  String imageUrl;
  String date;

  Event(
      {required this.title,
      required this.date,
      required this.imageUrl,
      required this.description});
}

List<Event> EventList = [
  Event(
      title: 'Flutter Workshop',
      date: '20, Oct 09:00 AM',
      imageUrl:
          'https://cdn-images-1.medium.com/max/1200/1*5-aoK8IBmXve5whBQM90GA.png',
      description:
          'The workshop presents the basic concepts needed to kick start your journey in Flutter.'),
  Event(
      title: 'Firebase workshop',
      date: '21, Nov 09:00 AM',
      imageUrl:
          'https://4.bp.blogspot.com/-Fxo_qnGJBj0/WRoDPNdlEII/AAAAAAAABF0/1mSHmv5gleQaCsHKEDgTB3DbNghjCXvZACLcB/s1600/logo_firebase_1920px_clr.png',
      description:
          'The interactive workshop will cover the fundamentals of Firebase, a cloud platform that assists you in creating your own web and mobile applications. Learn how to use Firebase'
          's Cloud Firestore database, authentication, and file hosting, and leave with a fully functional chat web app.'),
  Event(
      title: 'NodeJS Workshop',
      date: '10, Dec , 05:00 PM',
      imageUrl:
          'https://logos-download.com/wp-content/uploads/2016/09/Node_logo_NodeJS.png',
      description:
          'The workshop presents the basic concepts needed to kick start your journey in Node JS.'),
];
