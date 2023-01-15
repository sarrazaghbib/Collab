import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:collabapp/screens/Chat/widgets/widgets.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

   static Route route() => MaterialPageRoute(
    builder: (context)=>const SearchPage(
      
    ),
  );

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 54,
        leading: Align(
          alignment: Alignment.centerRight,
          child: IconBackground(
            icon: CupertinoIcons.back,
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),

      body:const Center(child: Text("SearchPage"),)
    );
  }
}