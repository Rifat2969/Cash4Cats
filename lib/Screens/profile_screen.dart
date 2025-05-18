import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Extention/number_ext.dart';
import '../provider/profile_provider.dart';
import 'contact.dart';
import 'password.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileProvider _profileProvider;

  final arrowIcon = const Icon(
    Icons.arrow_forward_ios,
    size: 25,
    color: Color(0xFF7C7F8A),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _profileProvider = Provider.of<ProfileProvider>(context);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _profileProvider.initViewModel();
    });
  }

  @override
  void dispose() {
    _profileProvider.disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profile = _profileProvider.profile;
    final isLoading = _profileProvider.isLoading;

    String getName() => profile?.data?.name ?? "Unknown";
    String getEmail() => profile?.data?.email ?? "Unknown";
    String getPhone() => profile?.data?.phone ?? "Unknown";
    String getAddress() => profile?.data?.address ?? "Unknown";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'My Profile',
          style: TextStyle(
            color: Color(0xFF303548),
            fontSize: 24,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              padding: const EdgeInsets.only(top: 50, right: 22, left: 22),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _profileInfo(getName(), getEmail()),
                    SizedBox(height: 3.2.height),
                    _sectionTitle('Profile Settings'),
                    _profileMenuCard('Contact us', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const Contact()),
                      );
                    }),
                    _profileMenuCard('Change your Password', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const Password()),
                      );
                    }),
                    _profileMenuCard('Language: English', () {}),
                    const Divider(),
                    SizedBox(height: 3.2.height),
                    _sectionTitle('Company Details'),
                    _informationCard('Company name:', 'NewAge Automobiles'),
                    _informationCard('Designation:', 'Sales Executive'),
                    _informationCard('Department:', 'Automobile Parts', showDivider: false),
                    SizedBox(height: 3.2.height),
                    _sectionTitle('Contact Info'),
                    _contactInfo('Name:', getName()),
                    _contactInfo('Phone number:', getPhone()),
                    _contactInfo('Email', getEmail()),
                    _contactInfo('Address', getAddress(), showDivider: false),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _profileInfo(String name, String email) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset('assets/images/profile.png', fit: BoxFit.cover),
          ),
        ),
        const SizedBox(width: 24),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                color: Color(0xFF303548),
                fontSize: 24,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              email,
              style: const TextStyle(
                color: Color(0xFF62656D),
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        )
      ],
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Color(0xFF303548),
        fontSize: 18,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        height: 1.55,
      ),
    );
  }

  Widget _profileMenuCard(String title, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Color(0xFF303548),
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  height: 1.60,
                ),
              ),
            ),
            arrowIcon
          ],
        ),
      ),
    );
  }

  Widget _informationCard(String label, String value, {bool showDivider = true}) {
    return Container(
      padding: const EdgeInsets.only(top: 14),
      child: Column(
        children: [
          Row(
            children: [
              Text(label,
                  style: const TextStyle(
                      color: Color(0xFF62656D), fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w400)),
              const Spacer(),
              Text(value,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                      color: Color(0xFF303548), fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w500))
            ],
          ),
          SizedBox(height: 1.6.height),
          if (showDivider) const Divider(),
        ],
      ),
    );
  }

  Widget _contactInfo(String label, String value, {bool showDivider = true}) {
    return _informationCard(label, value, showDivider: showDivider);
  }
}
