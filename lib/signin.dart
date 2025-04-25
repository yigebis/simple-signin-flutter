import 'dart:convert';
import 'dart:ui' as html;

import 'package:flutter/material.dart';



class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  Credential _credential1 = Credential.withCredentials("yigerem4@gmail.com", "secureP@ssw0rd");
  Credential _credential2 = Credential.withCredentials("merbebt@gmail.com", "P@ssw0rd");
  Credential _credential3 = Credential.withCredentials("xyz@gmail.com", "Thr33!=foUr");
  bool _showPassword = false;

  var givenCredential = Credential();
  late List<Credential> validCredentials;

  @override
  void initState() {
    super.initState();
    validCredentials = [_credential1, _credential2, _credential3];
  }

  String? _validateEmail(String email){
    if (email.isEmpty){
      return "Email is required";
    }
    if (!email.contains("@")){
      return "Email is not valid";
    }
    return null;
  }

  String? _validatePassword(String password){
    if (password.length < 8){
      return "Password should have a length of at least 8";
    }
    int upper = 0, lower = 0, digit = 0, special = 0;
    for (int i = 0; i < password.length; i++){
      var ascii = password[i].codeUnitAt(0);
      if (ascii >= 65 && ascii <= 90){
        upper++;
      }
      else if (ascii >= 97 && ascii <= 122){
        lower++;
      }
      else if(ascii >= 48 && ascii < 58){
        digit++;
      }
      else{
        special++;
      } 
    }

    if (lower * upper * special * digit == 0){
      return "password should contain at least one uppercase, lowercase, digit and special character";
    }

    return null;
  }

  void signIn() async{
    if (_formStateKey.currentState!.validate()){
      _formStateKey.currentState!.save();

      bool status = false;

      for (Credential cred in validCredentials){
        if (cred._email == givenCredential._email){
          if (cred._password == givenCredential._password){
            status = true;
            break;
          }
        }
      }

      if (status){
        Navigator.pushNamed(context, "/dashboard");
      }
      else{
        var errorMessage = "Invalid email or password";

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
          )
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(80.0),
        child: Form(
          key: _formStateKey,
          autovalidateMode: AutovalidateMode.onUnfocus,
          child : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: "Email"),
                validator: (value) => _validateEmail(value!),
                onSaved: (value) => givenCredential._email = value!,
              ),
              SizedBox(height: 8.0,),
              TextFormField(
                obscureText: !_showPassword,
                decoration: InputDecoration(
                  labelText: "Password",     
                  suffixIcon: IconButton(
                    icon: Icon(
                      _showPassword? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: (){
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    }
                  )
                ),
                validator: (value) => _validatePassword(value!),
                onSaved: (value) => givenCredential._password = value!,
              ),
              SizedBox(height : 8.0),
              ElevatedButton(
                onPressed: (){
                  signIn();
                }, 
                child: Text("Sign In"),
              )

            ],
          ),
        )
        
      ),
    );
  }
}

class Credential{
  late String _email;
  late String _password;

  Credential();
  
  Credential.withCredentials(email, password){
    this._email = email;
    this._password = password;
  }
}