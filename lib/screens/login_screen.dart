import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: LoginScreen(),
  ));
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/assets/login_screen_background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top,
            right: 16.0,
            child: IconButton(
              icon: Icon(Icons.notification_add_sharp, color: Colors.white, size: 30.0),
              onPressed: () {
                // Notifications page
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Text(
                  'Zoffy',
                  style: TextStyle(
                    fontSize: 36.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
                Spacer(),
                CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('lib/assets/myfoto.jpg'),
                ),
                SizedBox(height: 48.0),
                _buildTextField(_usernameController, 'Kullanıcı Adı'),
                SizedBox(height: 16.0),
                _buildPasswordTextField(),
                SizedBox(height: 30.0),
                _buildLoginButton('Giriş Yap', () {}),
                SizedBox(height: 12.0),
                _buildLoginButton('Müşteri Ol', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()),
                  );
                }),
                SizedBox(height: 8.0),
                _buildFlatButton('Şifremi Unuttum', onTap: () {}),
                Spacer(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Text(
                  '© Zoffy 2024',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Color.fromARGB(255, 220, 220, 220),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
      ),
      style: TextStyle(fontSize: 16.0),
    );
  }

  Widget _buildPasswordTextField() {
    return TextField(
      controller: _passwordController,
      obscureText: !_isPasswordVisible,
      decoration: InputDecoration(
        hintText: 'Şifre',
        filled: true,
        fillColor: Color.fromARGB(255, 220, 220, 220),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
            color: Color.fromARGB(255, 17, 0, 201),
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
      ),
      style: TextStyle(fontSize: 16.0),
    );
  }

  Widget _buildLoginButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 17, 0, 201),
        minimumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 10,
        padding: EdgeInsets.symmetric(vertical: 12.0),
      ),
    );
  }

  Widget _buildFlatButton(String text, {required VoidCallback onTap}) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        text,
        style: TextStyle(
          color: Color.fromARGB(255, 17, 0, 201),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _pageController = PageController();
  final _tcController = TextEditingController();
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _professionController = TextEditingController();
  final _incomeController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> registerUser() async {
    final url = Uri.parse('http://localhost:5175/api/User');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nickname': _usernameController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
        'name': _nameController.text,
        'surname': _surnameController.text,
        'tc': _tcController.text,
        'address': _addressController.text,
        'phone': _phoneController.text,
        'salary': _incomeController.text,
        'job': _professionController.text,
      }),
    );

    if (response.statusCode == 200) {
      // Kayıt başarılı, final sayfasına yönlendir
      _pageController.jumpToPage(3);
    } else {
      // Hata mesajı göster
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Hata'),
          content: Text('Kayıt sırasında bir hata oluştu.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Tamam'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/assets/login_screen_background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: PageView(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(), // Prevent swipe navigation
              children: [
                _buildPageOne(),
                _buildPageTwo(),
                _buildPageThree(),
                _buildFinalPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageOne() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(controller: _tcController, decoration: InputDecoration(labelText: 'TC Kimlik Numaranız')),
        TextField(controller: _nameController, decoration: InputDecoration(labelText: 'İsiminiz')),
        TextField(controller: _surnameController, decoration: InputDecoration(labelText: 'Soyisminiz')),
        TextField(controller: _phoneController, decoration: InputDecoration(labelText: 'Telefon Numaranız')),
        TextField(controller: _emailController, decoration: InputDecoration(labelText: 'E-posta Adresiniz')),
        SizedBox(height: 30.0), // Add SizedBox to create space between text fields and button
        _buildLoginButton('Devam Et', () => _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeIn)),
      ],
    );
  }

  Widget _buildPageTwo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(controller: _addressController, decoration: InputDecoration(labelText: 'Adresiniz')),
        TextField(controller: _professionController, decoration: InputDecoration(labelText: 'Mesleğiniz')),
        TextField(controller: _incomeController, decoration: InputDecoration(labelText: 'Aylık Kazancınız')),
        _buildLoginButton('Devam Et', () => _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeIn)),
      ],
    );
  }

  Widget _buildPageThree() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(controller: _usernameController, decoration: InputDecoration(labelText: 'Kullanıcı Adınızı Belirleyin')),
        TextField(controller: _passwordController, decoration: InputDecoration(labelText: 'Şifrenizi Belirleyin')),
        _buildLoginButton('Ayrıcalıklar Dünyasına Giriş Yap', registerUser),
      ],
    );
  }

  Widget _buildFinalPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Kaydınız Başarılı!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        _buildLoginButton('Giriş Sayfasına Dön', () {
          Navigator.pop(context);
        }),
      ],
    );
  }

  Widget _buildLoginButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 17, 0, 201),
        minimumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 10,
        padding: EdgeInsets.symmetric(vertical: 12.0),
      ),
    );
  }
}
