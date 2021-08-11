import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with TickerProviderStateMixin {
  String _email = '';
  String _password = '';
  String _confirmpassword = '';
  String _username = '';
  bool isSignIn = true;
  TextEditingController _passwordcontroller;

 final _formKey = GlobalKey<FormState>();


@override
  void initState() {
    // TODO: implement initState
    _passwordcontroller = TextEditingController();
    super.initState();
  }

void _onClickSubmit(){
var isValid = _formKey.currentState.validate();

if(isValid){
  _formKey.currentState.save();
  FocusScope.of(context).unfocus();
}
}
void _onClickSignUp(){
  setState(() {
      isSignIn = !isSignIn;
    });
}
 @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // _controller.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: LayoutBuilder(
        builder:(ctx,constraints){ return SingleChildScrollView(
          child: Column(
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeIn,
                // height:isSignIn? MediaQuery.of(context).size.height / 3:MediaQuery.of(context).size.height / 5,
                height:isSignIn? constraints.maxHeight / 3:constraints.maxHeight / 5,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50))),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: constraints.maxWidth/10,vertical: constraints.maxHeight/15),
                
                child: Card(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                curve: Curves.easeIn,
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                    decoration: BoxDecoration(),
                    child: 
                      Form(
                         key: _formKey,
                        child: Column(
                       
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: Colors.grey.shade100),
                            child: TextFormField(
                              key: ValueKey('email'),
                              validator: (value){
                                if(value.isEmpty||!value.contains('@')){
                                  return 'Invalid Email';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: 'Enter Your Email',
                                contentPadding: EdgeInsets.all(10),
                                icon: Icon(Icons.account_circle),
                                border: InputBorder.none
                              ),
                              onSaved: (value){
                                _email = value;
                              },
                            ),
                          ),
                          SizedBox(height: 15,),
                          if(!isSignIn)
                           Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: Colors.grey.shade100),
                            child: TextFormField(
                              key: ValueKey('username'),
                              validator: (value){
                                if(value.isEmpty||value.length<=5){
                                  return 'Length of username is too short';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                hintText: 'Username',
                                contentPadding: EdgeInsets.all(10),
                                icon: Icon(Icons.face),
                                border: InputBorder.none
                              ),
                              onSaved: (value){
                                _username = value;
                              },
                            ),
                          ),
                          SizedBox(height: 15,),
                          Container(
                            padding: EdgeInsets.all(10),
                            
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: Colors.grey.shade100),
                            child: TextFormField(
                              key: ValueKey('password'),
                              controller: _passwordcontroller,
                              validator: (value){
                                if(value.isEmpty||value.length<6){
                                  return 'Password must be atleast 6 characters long';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Enter Your Password',
                                contentPadding: EdgeInsets.all(10),
                                icon: Icon(Icons.account_circle),
                                border: InputBorder.none
                              ),
                              onSaved: (value){
                                _password = value;
                              },
                            ),
                          ),
                          SizedBox(height: 15),
                          if(!isSignIn)
                           
                             AnimatedSize(
  // If the widget is visible, animate to 0.0 (invisible).
  // If the widget is hidden, animate to 1.0 (fully visible).
 vsync: this,
  duration: Duration(milliseconds: 150),
  curve: Curves.fastOutSlowIn,

                             child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: Colors.grey.shade100),
                              child: TextFormField(
                                key: ValueKey('confirmpassword'),
                               validator: (value){
                                if(value.isEmpty||value.length<6){
                                  return 'Password must be atleast 6 characters long';
                                }
                                else if(value!=_passwordcontroller.text){
                                  return 'Passwords Do Not Match';
                                }
                                return null;
                              },
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: 'Reenter Password',
                                  icon: Icon(Icons.lock),
                                  contentPadding: EdgeInsets.all(10),
                                  border: InputBorder.none
                                ),
                                onSaved: (value){
                                _confirmpassword = value;
                              },
                              ),
                          ),
                           ),
                          SizedBox(height: 10),
                          ElevatedButton(onPressed: _onClickSubmit, child: isSignIn? Text('Log In'):Text('Sign Up')),
                         isSignIn? FlatButton(onPressed: _onClickSignUp, child: Text('Create New Account')):FlatButton(onPressed: _onClickSignUp, child: Text('Sign In Instead'))
                        ],
                      ))
                    ,
                  ),
                ),
              ),
              
            ],
          ),
        );
        }
      ),
    );
  }
}
