import 'package:flutter/material.dart';
import 'package:collabapp/model/event.dart';
import 'package:collabapp/screens/Events/event_details.dart';

class EventListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Upcoming Events'),
          backgroundColor: Color.fromARGB(255, 13, 71, 161),
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: ListView.builder(
            itemCount: EventList.length,
            itemBuilder: (context, index) {
              Event movie = EventList[index];
              return Card(
                child: ListTile(
                  title: Text(movie.title),
                  subtitle: Text(movie.date.toString()),
                  leading: Image.network(movie.imageUrl),
                  trailing: Icon(Icons.arrow_forward_rounded),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EventDetailsScreen(movie)));
                  },
                ),
              );
            }));
  }
}
