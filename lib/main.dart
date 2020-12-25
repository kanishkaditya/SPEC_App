import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Helper/AuthService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'register.dart';
import 'Helper/CustormTextField.dart';
import 'Helper/Handler.dart';


AuthService service;
FirebaseUser user;


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn=false;
  service=AuthService();
  if(prefs.containsKey('IsLoggedIn'))
    {
      isLoggedIn= prefs.getBool('IsLoggedIn');
    }

  if(isLoggedIn)
  {
    user=await service.signInWithGoogle();
    print(user.displayName+" "+user.email);
  }
  return runApp(MaterialApp(
      routes:{
        '/LoginPage':(context)=>LoginPage(title:'Login Page'),
        '/Handler':(context)=>MyApp(),
      },
      initialRoute: isLoggedIn?'/Handler':'/LoginPage',
  )
  );
}



class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  bool isvalid=true;
  bool isPasswordValid=true;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String _email;
  String _pass;


  @override
  Widget build(BuildContext context) {
    formKey.currentState?.validate();
    return Scaffold(
      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
                'Welcome',
                style:TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 30
                )),
              Form(
                key:formKey,
              autovalidateMode: AutovalidateMode.always,
              child:Column(
                children: <Widget>[
                CustomTextField(
                icon:Icon(Icons.email),
                onChanged:(input)=>_email=input,
                obsecure: false,
                hint:'Email',
                validator:(input)
                  {
                    if(!isvalid)
                      {return " ";}

                    return !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(input)?"*Please enter a valid email address":null;
                  }
              ),
             CustomTextField(
                icon:Icon(Icons.lock),
                obsecure: true,
                onChanged: (input) =>{_pass=input},
                hint:'Password',
                validator: (input)
                {
                  if(!isPasswordValid)
                    {
                      isPasswordValid=true;
                      return "*Please check your password";
                    }
                  if(!isvalid)
                    {isvalid=true;
                      return "*please check your email and Password";}
                  if(isvalid&&input.isEmpty)
                    return "*Required";
                  else return null;
                },
              ),
              ],),),
            Container(
                margin:EdgeInsets.only(right:20,left:20,top:20),
                child:Column(
                children: <Widget>[
                  ElevatedButton(
                      onPressed: ()async{
                        int check=await service.SignIn(_email, _pass);
                        if(check==-1)
                          {formKey.currentState.setState(() {
                            isvalid=false;
                          });
                          }
                        else if(check==1)
                          {formKey.currentState.setState(() {
                          isPasswordValid=false;
                          });
                          }
                      },
                      child: Text(
                      'Sign In',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 20
                    ),
                  )
                  ),
                  IconButton (
                    icon:Image.asset('assets/Image/google.png'),
                    iconSize:48,
                    onPressed: () {
                      service.signInWithGoogle().whenComplete(
                          (){
                            Navigator.pushReplacementNamed(context, '/Handler',);
                          }
                        );
                          }
                          ),
                ],
                    ),
            ),
          ],
            ),
            ),
    );
  }
}
