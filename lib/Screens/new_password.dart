import 'package:cash4cats/Screens/password_changed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({super.key});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  var password = TextEditingController();
  var confirmPassword = TextEditingController();
  bool obscureText = true;
  bool obscureText2 = true;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
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
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 80),
            const Text(
              'Set new password',
              style: TextStyle(
                color: Color(0xFF303548),
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                height: 1.55,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const SizedBox(
              width: 366,
              child: Text(
                'Please set a new password. We recommend to use a 8 character long password',
                style: TextStyle(
                  color: Color(0xFF5D616B),
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            const Text(
              'New Password',
              style: TextStyle(
                color: Color(0xFF2F3545),
                fontSize: 13,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                letterSpacing: 0.13,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            TextFormField(
              obscureText: obscureText,
              controller: password,
              decoration: InputDecoration(
                hintText: 'Password',
                hintStyle: const TextStyle(color: Colors.grey), // Use hintStyle for watermark
                border: InputBorder.none,
                suffixIcon: InkWell(
                  onTap: () => setState(() => obscureText = !obscureText),
                  child: Container(
                      height: 30,
                      width: 30,
                      alignment: Alignment.center,
                      child: obscureText
                          ? const Icon(
                              Icons.remove_red_eye_outlined,
                              color: Colors.grey, // Set the color to grey
                            )
                          : SvgPicture.asset('assets/svg_icons/EyeSlash.svg', height: 20)),
                ),
                focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
                obscureText: obscureText2,
                controller: confirmPassword,
                decoration: InputDecoration(
                  hintText: 'Confirm Password',
                  hintStyle: const TextStyle(color: Colors.grey), // Use hintStyle for watermark
                  border: InputBorder.none,
                  suffixIcon: InkWell(
                    onTap: () => setState(() => obscureText2 = !obscureText2),
                    child: Container(
                        height: 30,
                        width: 30,
                        alignment: Alignment.center,
                        child: obscureText2
                            ? const Icon(
                                Icons.remove_red_eye_outlined,
                                color: Colors.grey, // Set the color to grey
                              )
                            : SvgPicture.asset('assets/svg_icons/EyeSlash.svg', height: 30)),
                  ),
                  focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                  enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                ),
                onChanged: (value) {
                  setState(() {});
                },
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Conform password is required please enter';
                  }
                  if (value != password.text) {
                    return 'Confirm password not matching';
                  }
                  return null;
                }),
            const SizedBox(
              height: 10,
            ),
            if ((password.text == confirmPassword.text) &&
                (password.text.isNotEmpty && confirmPassword.text.isNotEmpty))
              const Text(
                'Passwords matched!',
                style: TextStyle(),
              ),
            const SizedBox(
              height: 40,
            ),
            InkWell(
              onTap: () {
                if ((password.text == confirmPassword.text) &&
                    (password.text.isNotEmpty && confirmPassword.text.isNotEmpty)) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PasswordChanged(),
                    ),
                  );
                }
              },
              child: Container(
                width: size.width,
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 10),
                decoration: ShapeDecoration(
                  color: ((password.text == confirmPassword.text) &&
                          (password.text.isNotEmpty && confirmPassword.text.isNotEmpty))
                      ? const Color(0xFF0053D2)
                      : Colors.grey, // Adjust color
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Confirm password',
                      style: TextStyle(
                        color: Colors.white, // Adjust text color
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.white, // Adjust icon color
                      size: 30,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
