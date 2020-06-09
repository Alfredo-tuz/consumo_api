import 'package:consumo_api/api/auth_api.dart';
import 'package:consumo_api/utils/responsive.dart';
import 'package:consumo_api/widgets/input_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:consumo_api/widgets/circle.dart';
 
class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>();
  final _authApi = AuthApi();
  var _email='',_password='';
  var _isFetching = false;


  @override
  void initState() { 
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light
    );
  }


  _submit() async{
    if(_isFetching) return;
    final isValid = _formKey.currentState.validate();
    if(isValid){
      setState(() {
        _isFetching=true;
      });
      final isOk = await _authApi.login(context, email: _email, password: _password);
      setState(() {
        _isFetching = false;
      });
      if(isOk){
        print('Login Ok');
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
                                height: responsive.hp(20),
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
                                height: responsive.hp(4),
                              ),
                              Text(
                                "Hello again",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: responsive.ip(3),
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
                                        label: "Email address",
                                        inputType: TextInputType.emailAddress,
                                        fontSize: responsive.ip(1.8),
                                        validator: (String text){
                                          if(text.contains("@")){
                                            _email = text;
                                            return null;
                                          }
                                          return "Invalid Email";
                                        },
                                      ),
                                      SizedBox(height: responsive.hp(3),),
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
                              SizedBox(height:responsive.hp(4)),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  minWidth: 350,
                                  maxWidth: 350
                                ),
                                child: CupertinoButton(
                                  padding: EdgeInsets.symmetric(vertical: responsive.ip(2)),
                                  child: Text('Sign in',
                                    style: TextStyle(
                                      fontSize: responsive.ip(2.5)
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
                                  Text('new to friendly desi',
                                    style: TextStyle(
                                      fontSize: responsive.ip(1.8),
                                      color: Colors.black54
                                    ),
                                  ),
                                  CupertinoButton(
                                    child:Text("Sign up",
                                    style: TextStyle(
                                      fontSize: responsive.ip(1.8),
                                      color: Colors.pinkAccent
                                    )
                                    ), 
                                    onPressed:()=>Navigator.pushNamed(context, "signup")
                                  )
                                ],
                              ),
                              SizedBox(height: responsive.hp(5),)
                            ],
                          )
                          
                        ],
                      ),
                    ),
                  ),
              ),

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