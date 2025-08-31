import 'package:cash4cats/Extention/number_ext.dart';
import 'package:cash4cats/Screens/categories.dart';
import 'package:cash4cats/Screens/pgm_prices.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bottom_sheets/language_sheet.dart';
import '../provider/login_provider.dart';
import '../screens/splash_screen.dart';
import '../utils/size_config.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var modelData = LoginProvider();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<LoginProvider>(context, listen: false).initViewModel();
    });
  }

  @override
  void didChangeDependencies() {
    modelData = Provider.of<LoginProvider>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.initMediaQuery(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Center(
                      child: Image.asset('assets/images/logo.png', height: 60),
                    ),
                    SizedBox(height: 5.height),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'hello'.tr(),
                          style: const TextStyle(
                            color: Color(0xFF303548),
                            fontSize: 30,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 1.height),
                        Text(
                          'welcome'.tr(),
                          style: const TextStyle(
                            color: Color(0xFF62656D),
                            fontSize: 18,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.height),
                    TextField(
                      controller: modelData.emailController,
                      onChanged: (_) => setState(() {}),
                      decoration: InputDecoration(
                        hintText: 'email'.tr(),
                        hintStyle: const TextStyle(color: Color(0xFF62656D)),
                        suffixIcon: const Icon(Icons.mail_outline, color: Colors.grey),
                        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                        enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                      ),
                    ),
                    const SizedBox(height: 25),
                    TextFormField(
                      obscureText: modelData.obscureText,
                      controller: modelData.passwordController,
                      onChanged: (_) => setState(() {}),
                      decoration: InputDecoration(
                        hintText: 'password'.tr(),
                        hintStyle: const TextStyle(color: Color(0xFF62656D)),
                        suffixIcon: IconButton(
                          icon: Icon(
                            modelData.obscureText ? Icons.visibility : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: modelData.togglePasswordVisibility,
                        ),
                        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                        enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Checkbox(
                          value: modelData.isChecked,
                          activeColor: Colors.black,
                          onChanged: modelData.setChecked,
                        ),
                        Text(
                          "keepLoggedIn".tr(),
                          style: const TextStyle(fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w500),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const Categories()));
                          },
                          child: Text(
                            'forgotPassword'.tr(),
                            style: const TextStyle(
                              color: Color(0xFF3467EE),
                              fontSize: 15,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    GestureDetector(
                      onTap: () async {
                        if (!modelData.isValid) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Please enter a valid email & password")),
                          );
                          return;
                        }

                        final success = await modelData.login();
                        if (!mounted) return;

                        if (success) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => const Categories()),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Invalid credentials")),
                          );
                        }
                      },
                      child: Container(
                        width: 100.width,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: modelData.isValid ? const Color(0xFF0053D2) : Colors.grey,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: modelData.isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : Text(
                                'login'.tr(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                      ),
                    ),
                    /*   InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Categories()));
                      },
                      child: Container(
                        width: 100.width,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: modelData.isValid ? const Color(0xFF0053D2) : Colors.grey,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: modelData.isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : Text(
                                'login'.tr(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                      ),
                    ),*/
                    SizedBox(height: 2.height),
                    Center(
                      child: GestureDetector(
                        onTap: () async {
                          final result = await LanguageSheet.show(context);
                          if (result != null) {
                            modelData.setLanguage(result["name"]!, result["flag"]!);
                          }
                        },
                        child: Container(
                          width: 60.width,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFF0053D2)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Text(modelData.selectedFlag, style: const TextStyle(fontSize: 24)),
                              const SizedBox(width: 10),
                              Text(modelData.selectedCountry, style: const TextStyle(fontSize: 16)),
                              const Spacer(),
                              const Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: modelData.loader
                    ? const CircularProgressIndicator()
                    : modelData.pgmlist.isEmpty
                        ? const Text("PGM Prices Not Available")
                        : SizedBox(
                            height: 100,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: modelData.pgmlist.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const PgmPrices()));
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 100,
                                    margin: const EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          ['PT', 'PD', 'RH'][index],
                                          style: TextStyle(
                                            color: [Colors.blue, Colors.red, Colors.black][index],
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'AUD\$ ',
                                              style: TextStyle(
                                                color: [Colors.blue, Colors.red, Colors.black][index],
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              '${modelData.pgmlist[index]}',
                                              style: TextStyle(
                                                color: [Colors.blue, Colors.red, Colors.black][index],
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
              ),
              ElevatedButton(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setBool('hasSeenOnboarding', false);
                  if (!context.mounted) return;
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const SplashScreen()),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                ),
                child: const Text('Reset Onboarding (Dev)'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
