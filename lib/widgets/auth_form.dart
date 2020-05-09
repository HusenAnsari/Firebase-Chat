import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final bool isLoading;
  final void Function(String email, String username, String password,
      bool isLogin, BuildContext ctx) submitFunction;

  AuthForm(this.submitFunction, this.isLoading);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userName = '';
  var _userEmail = '';
  var _userPassword = '';

  void _trySubmit() {
    // to validate validation of of Form()'s TextFormField()
    final isValid = _formKey.currentState.validate();

    // Close soft keyboard if open when we click on submit button
    FocusScope.of(context).unfocus();

    if (isValid) {
      // Trigger all save() of Form()'s TextFormField()
      _formKey.currentState.save();
      widget.submitFunction(_userEmail.trim(), _userName.trim(),
          _userPassword.trim(), _isLogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  // we need to add key if we have multiple same field
                  key: ValueKey('email'),
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Please enter valid email address.';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                  onSaved: (value) {
                    _userEmail = value;
                  },
                ),

                // Use to remove field from array of Column.
                // Show/remove widget after if condition if condition true/false
                if (!_isLogin)
                  TextFormField(
                    key: ValueKey('username'),
                    validator: (value) {
                      if (value.isEmpty || value.length < 4) {
                        return 'Please enter at least 4 charactors.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Username',
                    ),
                    onSaved: (value) {
                      _userName = value;
                    },
                  ),

                TextFormField(
                  key: ValueKey('password'),
                  validator: (value) {
                    if (value.isEmpty || value.length < 7) {
                      return 'Password must be 7 charactors long.';
                    }
                    return null;
                  },
                  // To hide text in password field.
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  onSaved: (value) {
                    _userPassword = value;
                  },
                ),
                SizedBox(
                  height: 12,
                ),
                if (widget.isLoading)
                  CircularProgressIndicator(),
                if (!widget.isLoading)
                  RaisedButton(
                    child: Text(_isLogin ? 'Login' : 'SignUp'),
                    onPressed: _trySubmit,
                  ),
                if (!widget.isLoading)
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text(_isLogin
                        ? 'Create new account'
                        : 'I already have an Account'),
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
