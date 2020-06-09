import 'dart:async';

import 'package:consumo_api/models/user.dart';
import 'package:consumo_api/providers/me.dart';
import 'package:consumo_api/utils/dialogs.dart';
import 'package:consumo_api/utils/session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Me _me;
  @override
  void initState() { 
    super.initState();
    
  }

  _onExit(){
    Dialogs.confirm(context,title: "Confirm",message: "Are you sure?",onCancel: (){
      Navigator.pop(context);
    },
    onConfirm: () async{
      Navigator.pop(context);
      Session session = Session();
      await session.clear();

      Navigator.pushNamedAndRemoveUntil(context,"login",(_)=>false);
    });
  }

  @override
  Widget build(BuildContext context) {
    _me= Me.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        brightness: Brightness.light,
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
            onSelected: (String value){
              if(value=="exit"){
                _onExit();
              }
            },
            itemBuilder: (context)=>[
              PopupMenuItem(
                value: "Share",
                child:Text("share app")
              ),
              PopupMenuItem(
                value: "exit",
                child:Text("Exit app")
              )
            ]
          )
        ]
      ),
       body: Center(
         child: Text(_me.data.toJson().toString()),
       ),
    );
  }
}