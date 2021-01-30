import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:spec_app/Components/Animations/typewriter_box.dart';
import 'package:spec_app/Components/CustomWidget/CustormTextField.dart';
import 'package:spec_app/Helper/GradientUtil.dart';
import 'package:spec_app/main.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> with TickerProviderStateMixin {
  bool isvalid = true;

  bool isPasswordValid = true;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static AnimationController _loginButtonController;
  var buttonSqueezeAnimation;
  var buttonZoomout;
  String _email;
  String _pass;

  @override
  void dispose() {
    _loginButtonController.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();

    _loginButtonController = AnimationController(
        duration: Duration(milliseconds: 1500), vsync: this);
    _loginButtonController.addListener(() {
      if (_loginButtonController.isCompleted) {
        Navigator.pushReplacementNamed(context, '/Handler');
      }
    });

    buttonSqueezeAnimation = Tween<double>(
      begin: 320.0,
      end: 70.0,
    ).animate(CurvedAnimation(
        parent: _loginButtonController, curve: new Interval(0.0, 0.250)));

    buttonZoomout = new Tween<double>(
      begin: 70.0,
      end: 1100,
    ).animate(CurvedAnimation(
      parent: _loginButtonController,
      curve: Interval(
        0.550,
        0.900,
        curve: Curves.easeIn,
      ),
    ));
  }

  Future<Null> _playAnimation() async {
    try {
      await _loginButtonController.forward();
      //    await _loginButtonController.reverse();
    } on TickerCanceled {}
  }

  @override
  Widget build(BuildContext context) {
    formKey.currentState?.validate();
    TextStyle defaultStyle = TextStyle(color: Colors.grey, fontSize: 15.0);
    TextStyle linkStyle = TextStyle(color: Colors.blue);
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(gradient: GradientUtil.greenRed()),
      child: Column(
        children: <Widget>[
          Container(
            // alignment: Alignment.center,
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
            child: Column(
              children: [
                Box(),
                // Text('Welcome',
                //     style: TextStyle(fontFamily: 'Montserrat', fontSize: 30)),
                Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    children: <Widget>[
                      CustomTextField(
                          icon: Icon(Icons.email),
                          onChanged: (input) => _email = input,
                          obsecure: false,
                          hint: 'Email',
                          validator: (input) {
                            if (!isvalid) {
                              return " ";
                            }
                            return !RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(input)
                                ? "*Please enter a valid email address"
                                : null;
                          }),
                      CustomTextField(
                        icon: Icon(Icons.lock),
                        obsecure: true,
                        onChanged: (input) => {_pass = input},
                        hint: 'Password',
                        validator: (input) {
                          if (!isPasswordValid) {
                            isPasswordValid = true;
                            return "*Please check your password";
                          }
                          if (!isvalid) {
                            isvalid = true;
                            return "*please check your email and Password";
                          }
                          if (isvalid && input.isEmpty)
                            return "*Required";
                          else
                            return null;
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            //alignment: Alignment.center,
            padding: EdgeInsets.only(
              top: 50,
            ),
            //     left: MediaQuery.of(context).size.width * 0.38),
            child: RichText(
              text: TextSpan(
                style: defaultStyle,
                children: <TextSpan>[
                  TextSpan(
                      text: 'New User, Sign up',
                      style: linkStyle,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(
                            context,
                            '/Register',
                          );
                        }),
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            //   height: double.infinity,
            // width: double.infinity,
            child: AnimatedBuilder(
                animation: _loginButtonController,
                builder: (context, child) {
                  return Padding(
                    padding: buttonZoomout.value == 70
                        ? const EdgeInsets.only(top: 50)
                        : const EdgeInsets.only(top: 0.0, bottom: 0.0),
                    child: InkWell(
                      onTap: () async {
                        user = await service.SignIn(
                            email: _email, password: _pass);
                        if (user == null) {
                          formKey.currentState.setState(() {
                            isvalid = false;
                          });
                        } else {
                          _playAnimation();
                        }
                      },
                      child: Container(
                          width: buttonSqueezeAnimation.value == 70
                              ? buttonZoomout.value
                              : buttonSqueezeAnimation.value,
                          height: buttonZoomout.value == 70
                              ? 60.0
                              : buttonZoomout.value,
                          alignment: FractionalOffset.center,
                          decoration: BoxDecoration(
                            color: buttonZoomout.value == 70
                                ? const Color.fromRGBO(247, 64, 106, 1.0)
                                : const Color.fromRGBO(243, 65, 106, 1.0),
                            borderRadius: buttonZoomout.value < 400
                                ? new BorderRadius.all(
                                    const Radius.circular(30.0))
                                : new BorderRadius.all(
                                    const Radius.circular(0.0)),
                          ),
                          child: buttonSqueezeAnimation.value > 75.0
                              ? Text(
                                  "Sign In",
                                  style: new TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w300,
                                    letterSpacing: 0.3,
                                  ),
                                )
                              : buttonZoomout.value < 300.0
                                  ? CircularProgressIndicator(
                                      value: null,
                                      strokeWidth: 1.0,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                    )
                                  : null),
                    ),
                  );
                }),
          )
        ],
      ),
    ));
  }
}
