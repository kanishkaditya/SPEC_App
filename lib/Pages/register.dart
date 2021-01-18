import 'dart:io';
import 'dart:ui';
import 'package:spec_app/main.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Register extends StatefulWidget{
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _emailController=TextEditingController();
  final _name=TextEditingController();
  final _surname=TextEditingController();
  String _branch;
  bool _isCR=false;
  String _year;

  bool isvalid=true;
  File _imageFile;
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
                  ),
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
                  controller:_name,
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
                  controller:_surname,
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
                  controller: _emailController,
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
                      return "Password must be at least 6 characters";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Password",
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
              Padding(
                padding: EdgeInsets.only(top:15,left: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children:
                    [Text('B',style: TextStyle(color: Colors.black38,fontWeight: FontWeight.w900,fontSize: 25),),
                      SizedBox(width: 10,),
                    new DropdownButton<String>(
                      value:_branch,
                      items: <String>['ECE', 'CSE', 'ECD', 'CSED','CE','MS','ME','Civil'].map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {_branch=value;setState(() {});},
                      hint: Text('branch'),
                    ),]
                    ),
                    Row(
                      children:
                    [Text('Is CR'),
                    Checkbox(value: _isCR, onChanged: (value){_isCR=value;setState(() {});})],
                    ),
                    Row(
                      children: [
                        Icon(Icons.calendar_today_rounded),
                       SizedBox(width: 10,),
                       new DropdownButton<String>(
                         value: _year,
                      items: <String>['First Year','Second Year','Third Year','Fourth Year'].map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                         onChanged: (value) {
                           _year=value;
                           setState(() {});},
                         hint: Text('Year'),
                    ),]
                    )
                  ],
                )
              ),
              FloatingActionButton(
                onPressed: ()async{
                 if(_formKey.currentState.validate()&&_branch!=null&&_year!=null)
                   {
                     String name=_name.value.text;
                     String surname=_surname.value.text;
                     String email=_emailController.value.text;
                     String password=_passwordController.value.text;
                     branch=_branch;
                     year=_year;
                     user=await service.SignUp(name,surname,email,password,_imageFile,!_isCR,_year.replaceAll(new RegExp(r"\s+"), ""),_branch);
                     if(user!=null)
                       {Navigator.pushReplacementNamed(context, '/Handler',);}
                   }
                },
                child: Icon(Icons.done),

              )
            ],
          ),
        );
  }

  void TakePhoto(ImageSource source) async
  {
    final PickedFile = await _picker.getImage(
      source: source,
    );

    setState(() {
      _imageFile = File(PickedFile.path);
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
          ),
        ],
      ),
    );
  }
}




