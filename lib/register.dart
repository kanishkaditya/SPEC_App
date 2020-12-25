import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool isvalid=true;
  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 50 , horizontal: 10),
          child: Container(
            child: buildForm(),
          ),
        ),
      ),
    );
  }

  Form buildForm() {
    return Form(
          key: _formKey,
          child: Column(
            children: [
              Text("SignUP" , style: TextStyle(fontFamily: 'Montserrat', fontSize: 40),textAlign: TextAlign.center,),
              Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0),),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundImage: _imageFile == null? AssetImage("assets/Image/default_image.png"): FileImage(File(_imageFile.path)),
                  ) ,
                  Positioned(
                    bottom: 14,
                    right: 12,
                    child: InkWell(
                      onTap: (){
                        showModalBottomSheet(
                          context: context,
                          builder: ((builder) => BottomSheet()),
                        );
                      },
                        child: Icon(Icons.image_search , color: Colors.white70,)
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: TextFormField(
                  validator: (String value){
                    if(value.isEmpty){
                      return "Name cant be null";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Name",
                    icon: Icon(Icons.account_circle , size: 30,),
                    hintText: "Enter your name",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "Surname",
                     icon: Icon(Icons.account_circle , size: 30,)
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (String value){
                      if(!isvalid)
                      {return " ";}

                      return !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)?"*Please enter a valid email address":null;
                    },
                  decoration: InputDecoration(
                      labelText: "Email",
                      icon: Icon(Icons.email , size: 30,)
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  obscureText: true,
                  controller: _passwordController,
                  validator: (String value){
                    if(value.isEmpty){
                      return "Password cant be null";
                    }
                    else if(value.length < 6){
                      return "Password must be at leasr 6 characters";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Password",
                      hintText: "Enter your Password",
                      icon: Icon(Icons.lock , size: 30,)
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  obscureText: true,
                  controller: _confirmPasswordController,
                  validator: (String value){
                    if(value!=_passwordController.value.text){
                      return "Password does not match";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Confirm Password",
                      icon: Icon(Icons.lock , size: 30,)
                  ),
                ),
              ),
              FloatingActionButton(
                onPressed: (){
                  _formKey.currentState.validate();
                },
                child: Icon(Icons.done),

              )
            ],
          ),
        );
  }

  void TakePhoto(ImageSource source) async{
    final PickedFile = await _picker.getImage(
      source: source,
    );

    setState(() {
      _imageFile = PickedFile;
    });
  }

  Widget BottomSheet(){
    return Container(
      height: 100.0,
      margin: EdgeInsets.symmetric( horizontal: 20 ,vertical: 20),
      child: Column(
        children: [
          Text("Choose profile photo"),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton.icon(
                icon: Icon(Icons.camera),
                label: Text("Camera"),
                onPressed: (){
                  TakePhoto(ImageSource.camera);
                },
              ) ,
              FlatButton.icon(
                icon: Icon(Icons.image),
                label: Text("Gallery"),
                onPressed: (){
                  TakePhoto(ImageSource.gallery);
                },
              )
            ],
          )
        ],
      ),

    );
  }
}




