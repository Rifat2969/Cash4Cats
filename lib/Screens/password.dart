import 'package:cash4cats/Extention/number_ext.dart';
import 'package:cash4cats/Screens/new_password.dart';
import 'package:flutter/material.dart';

class Password extends StatefulWidget {
  const Password({super.key});

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  var name = TextEditingController();
  var password = TextEditingController();
  bool isChecked = false;
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    bool isActive = password.text.isNotEmpty;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Password',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF303548),
            fontSize: 24,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 14.6.height,
            ),
            const Text(
              'Please type your password',
              style: TextStyle(
                color: Color(0xFF303548),
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                height: 1.55,
              ),
            ),
            SizedBox(height: .8.height),
            const SizedBox(
              width: 380,
              child: Text(
                'To change your password, we need to verify your identity by giving us your password',
                style: TextStyle(
                  color: Color(0xFF62656D),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  height: 1.60,
                ),
              ),
            ),
            SizedBox(height: 3.2.height),
            TextFormField(
              obscureText: obscureText,
              controller: password,
              onChanged: (value) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'password',
                hintStyle: const TextStyle(color: Color(0xFF62656D)),
                suffixIcon: GestureDetector(
                  onTap: () => setState(() => obscureText = !obscureText),
                  child: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
              ),
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: isActive
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const NewPassword()),
                      );
                    }
                  : null,
              child: Container(
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isActive ? const Color(0xFF0053D2) : Colors.grey,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'Proceed',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
