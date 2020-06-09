import 'package:consumo_api/api/auth_api.dart';
import 'package:consumo_api/utils/responsive.dart';
import 'package:consumo_api/widgets/input_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:consumo_api/widgets/circle.dart';
 
class SignUpPage extends StatefulWidget {

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final _formKey = GlobalKey<FormState>();
  final _authAPI = AuthApi();
  var _isFetching = false;
  var _username = '',_email='',_password='';

  @override
  void initState() { 
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light
    );
  }


  _submit() async{
    if(_isFetching) return;
    final is_valid = _formKey.currentState.validate();
    if(is_valid){
      setState(() {
        _isFetching=true;
      });
      final isOk = await _authAPI.register(context,username:_username,email:_email,password: _password);
      setState(() {
        _isFetching=false;
      });
      if(isOk){
        print("Registrado exitoso");
        Navigator.pushNamedAndRemoveUntil(context, "splash", (_)=>false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final responsive  = new Responsive(context);


    return Scaffold(
      body: GestureDetector(
      child: Container(
          width: size.width,
          height: size.height,
          child: Stack(
            children: <Widget>[
              Positioned(
                right: -size.width*0.22,
                top: -size.width*0.36,
                child:Circle(
                  radius: size.width*0.45, 
                  colors: [
                    Colors.pink,
                    Colors.pinkAccent
                  ]
                )
              ),
              Positioned(
                left: -size.width*0.15,
                top: -size.width*0.34,
                child:Circle(
                  radius: size.width*0.35, 
                  colors: [
                    Colors.orange,
                    Colors.deepOrange
                  ]
                )
              ),
              SingleChildScrollView(
                child: Container(
                    width: size.width,
                    height: size.height,
                    child: SafeArea(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                          Column(
                            children: <Widget>[
                              Container(
                                width: responsive.wp(20),
                                height: responsive.wp(20),
                                margin: EdgeInsets.only(top:size.width*0.3),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius:25 
                                    )
                                  ]
                                ),
                              ),
                              SizedBox(
                                height: responsive.hp(3),
                              ),
                              Text(
                                "Hello again",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: responsive.ip(1.9),
                                  fontWeight: FontWeight.w300
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  minWidth: 350,
                                  maxWidth: 350
                                ),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    children: <Widget>[
                                      InputText(
                                        label: "User name",
                                        fontSize: responsive.ip(1.8),
                                        validator: (String text){
                                          if(RegExp(r'^[a-zA-z0-9]+$').hasMatch(text)){
                                            _username = text;
                                            return null;
                                          }
                                          return "Invalid user name";
                                        },
                                      ),
                                      InputText(
                                        label: "Email address",
                                        fontSize: responsive.ip(1.8),
                                        inputType: TextInputType.emailAddress,
                                        validator: (String text){
                                          if(text.contains("@")){
                                            _email = text;
                                            return null;
                                          }
                                          return "Invalid Email";
                                        },
                                      ),
                                      SizedBox(height: responsive.hp(1.5),),
                                      InputText(
                                        label: "Password",
                                        fontSize: responsive.ip(1.8),
                                        isSecure: true,
                                        validator: (String text){
                                          if(text.isNotEmpty && text.length > 5){
                                            _password = text;
                                            return null;
                                          }
                                          return "Invalid passsword";
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height:responsive.hp(5)),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  minWidth: 350,
                                  maxWidth: 350
                                ),
                                child: CupertinoButton(
                                  padding: EdgeInsets.symmetric(vertical: responsive.ip(1.9)),
                                  child: Text('Sign up',
                                    style: TextStyle(
                                      fontSize: responsive.ip(1.9)
                                    ),
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.pinkAccent, 
                                  onPressed: ()=>_submit()
                                ),
                              ),
                              SizedBox(height:responsive.hp(2)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text('Already have an account?',
                                    style: TextStyle(
                                      fontSize: responsive.ip(1.7),
                                      color: Colors.black54
                                    ),
                                  ),
                                  CupertinoButton(
                                    child:Text("Sign In",
                                    style: TextStyle(
                                      fontSize: responsive.ip(1.7),
                                      color: Colors.pinkAccent
                                    )
                                    ), 
                                    onPressed: ()=>Navigator.pop(context)
                                  )
                                ],
                              )
                            ],
                          )
                          
                        ],
                      ),
                    ),
                  ),
              ),
              Positioned(
                left: 15,
                top: 5,
                child:SafeArea(
                  child: CupertinoButton(
                    color: Colors.black12,
                    padding: EdgeInsets.all(10),
                    borderRadius: BorderRadius.circular(30),
                    child: Icon(Icons.arrow_back,color: Colors.white,), 
                    onPressed:()=>Navigator.pop(context)
                  ),
                )
              ),
              //Start Fecthing Dialog
              _isFetching?  Positioned.fill(child: Container(
                color: Colors.black45,
                child: Center(
                  child: CupertinoActivityIndicator(
                    radius: 15,
                  ),
                ),
              )) 
              : 
              Container()
              //End
            
            ],
          ),
        ),
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      ),
    );
  }
}