import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shop/errors/auth_errors.dart';
import 'package:shop/providers/auth.dart';
import 'package:shop/utils/input_validator.dart';

enum AuthMode { Login, SignUp }

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  AuthMode _authMode = AuthMode.Login;
  final TextEditingController _passwordController = TextEditingController();
  bool _showPasswordText = false;
  bool _isLoading = false;

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    _formKey.currentState.save();

    AuthProvider auth = Provider.of(context, listen: false);

    try {
      if (_authMode == AuthMode.Login) {
        await auth.signInWithPassword(
            _authData['email'], _authData['password']);
      } else {
        await auth.signUp(_authData['email'], _authData['password']);
      }
    } on AuthErrors catch (error) {
      Fluttertoast.showToast(
        msg: error.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (error) {
      print(error);
      Fluttertoast.showToast(
        msg: 'Ocorreu um erro inesperado.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  void switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() => _authMode = AuthMode.SignUp);
    } else {
      setState(() => _authMode = AuthMode.Login);
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xFF4A00E0),
    ));

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF8E2DE2),
                  Color(0xFF4A00E0),
                ],
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.shopping_basket_outlined,
                          color: Colors.white,
                          size: 32,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Shops'.toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 28,
                            letterSpacing: 3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  if (_isLoading)
                    CircularProgressIndicator.adaptive(
                      semanticsLabel: 'Carregando',
                      semanticsValue: 'Carregando',
                      valueColor: AlwaysStoppedAnimation(
                        Theme.of(context).primaryColor,
                      ),
                      backgroundColor: Colors.white,
                    ),
                  if (!_isLoading)
                    Container(
                      width: deviceWidth * 0.8,
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16.0,
                            horizontal: 16.0,
                          ),
                          child: Form(
                            key: _formKey,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            child: Column(
                              children: [
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                  ),
                                  validator: (value) =>
                                      InputValidator.email(value),
                                  onSaved: (value) =>
                                      _authData['email'] = value,
                                ),
                                TextFormField(
                                  controller: _passwordController,
                                  autocorrect: false,
                                  obscureText: !_showPasswordText,
                                  keyboardType: TextInputType.text,
                                  validator: (value) =>
                                      InputValidator.password(value),
                                  decoration: InputDecoration(
                                    labelText: 'Senha',
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _showPasswordText
                                            ? Icons.remove_red_eye_outlined
                                            : Icons.visibility_off_outlined,
                                      ),
                                      color: _showPasswordText
                                          ? Theme.of(context).primaryColor
                                          : Theme.of(context).buttonColor,
                                      onPressed: () => setState(
                                        () => _showPasswordText =
                                            !_showPasswordText,
                                      ),
                                    ),
                                  ),
                                  onSaved: (value) =>
                                      _authData['password'] = value,
                                ),
                                if (_authMode == AuthMode.SignUp)
                                  TextFormField(
                                    obscureText: !_showPasswordText,
                                    validator: _authMode == AuthMode.SignUp
                                        ? (value) =>
                                            InputValidator.checkPassword(
                                              value,
                                              _passwordController.text,
                                            )
                                        : null,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      labelText: 'Confirme a sua senha',
                                    ),
                                  ),
                                SizedBox(
                                  height: 40,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 24,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                  onPressed: _submit,
                                  child: Text(
                                    _authMode == AuthMode.Login
                                        ? 'Entrar'
                                        : 'Registrar',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (!_isLoading)
                    if (!_isLoading) SizedBox(height: 30),
                  if (!_isLoading)
                    TextButton(
                      style: TextButton.styleFrom(primary: Colors.white),
                      onPressed: switchAuthMode,
                      child: Text(
                        _authMode == AuthMode.Login
                            ? 'Não tem conta? Registre-se aqui!'
                            : 'Já tem conta? Faça seu login!',
                      ),
                    ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
