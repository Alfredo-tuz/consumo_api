import 'package:consumo_api/api/auth_api.dart';
import 'package:consumo_api/api/profile_api.dart';
import 'package:consumo_api/models/user.dart';
import 'package:consumo_api/providers/me.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  final _authApi = AuthApi();
  final _profileApi = ProfileAPI();
  Me _me;

  
  @override
  void initState() { 
    super.initState();
    this.check();
    
  }

  check() async{
    final token = await _authApi.getAccessToken();
    if(token != null){
      final result = await _profileApi.getUserInfo(context, token);
       final user = User.fromJson(result);
      print(user); 

      print(result.toString());
      _me.data =user;

      return Navigator.pushReplacementNamed(context, "home");
    }else{
      return Navigator.pushReplacementNamed(context, "login");
    }
  }


  @override
  Widget build(BuildContext context) {
    _me = Me.of(context);
    return Scaffold(
      body: Center(
        child: CupertinoActivityIndicator(
          radius: 15,
        ),
      ),
    );
  }
}