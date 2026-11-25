import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const PlayZupiApp());
}

const Color black = Color(0xFF111111);
const Color gold = Color(0xFFFFC83D);
const Color white = Color(0xFFFFFFFF);
const Color grey = Color(0xFFE8E8E8);

// APP

class PlayZupiApp extends StatelessWidget {
  const PlayZupiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PlayZupi',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: white,
        fontFamily: 'Roboto',
      ),
      home: const MainScreen(),
    );
  }
}

// MAIN SCREEN

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  final List<String> tabNames = [
    'Home', 'Room', 'Game', 'Wallet', 'Friend', 'Profile',
  ];

  final List<IconData> tabIcons = [
    Icons.home_rounded,
    Icons.mic_rounded,
    Icons.sports_esports_rounded,
    Icons.account_balance_wallet_rounded,
    Icons.people_alt_rounded,
    Icons.person_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [white, Color(0xFFF7F7F7), Color(0xFFE1E1E1)],
          ),
        ),
        child: SafeArea(
          child: selectedIndex == 0
              ? const HomeScreen()
              : selectedIndex == 5
                  ? const ProfileScreen()
                  : OtherTabScreen(
                      title: tabNames[selectedIndex],
                      icon: tabIcons[selectedIndex],
                    ),
        ),
      ),
      bottomNavigationBar: buildBottomNavigation(),
    );
  }

  Widget buildBottomNavigation() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [white, Color(0xFFE4E4E4)],
        ),
        border: const Border(
          top: BorderSide(color: Color(0xFFBDBDBD), width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: black.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 8, 5, 5),
          child: Row(
            children: List.generate(6, (index) {
              final bool active = selectedIndex == index;

              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() => selectedIndex = index);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    padding: const EdgeInsets.symmetric(vertical: 9),
                    decoration: BoxDecoration(
                      gradient: active
                          ? const LinearGradient(
                              colors: [
                                Color(0xFFFFE49A),
                                gold,
                                Color(0xFFE7A900),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            )
                          : null,
                      color: active ? null : white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: active ? black : const Color(0xFFCCCCCC),
                        width: active ? 1.5 : 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: black.withOpacity(0.13),
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(tabIcons[index], size: 23, color: black),
                        const SizedBox(height: 4),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            tabNames[index],
                            style: const TextStyle(
                              color: black,
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

// HOME SCREEN

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(15, 13, 15, 25),
      child: Column(
        children: [
          Row(
            children: [
              const Spacer(),
              Stack(
                alignment: Alignment.topCenter,
                clipBehavior: Clip.none,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.italic,
                          letterSpacing: -2,
                        ),
                        children: [
                          TextSpan(
                            text: 'Play',
                            style: TextStyle(color: black),
                          ),
                          TextSpan(
                            text: 'Zupi',
                            style: TextStyle(color: gold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Positioned(
                    top: -8,
                    child: Icon(
                      Icons.workspace_premium,
                      color: gold,
                      size: 42,
                    ),
                  ),
                  Positioned(
                    bottom: -6,
                    left: 0,
                    right: 0,
                    child: Container(height: 3, color: gold),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [white, grey],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(color: gold, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: black.withOpacity(0.25),
                      blurRadius: 8,
                      offset: const Offset(2, 4),
                    ),
                  ],
                ),
                child: IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Settings coming soon'),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.settings,
                    color: black,
                    size: 29,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const WelcomeCard(),
          const SizedBox(height: 28),
          const DailyOption(
            title: 'Daily Reward',
            icon: Icons.card_giftcard_rounded,
          ),
          const DailyOption(
            title: 'Daily Event',
            icon: Icons.calendar_month_rounded,
          ),
          const DailyOption(
            title: 'Daily Update',
            icon: Icons.update_rounded,
          ),
          const DailyOption(
            title: 'New Reward',
            icon: Icons.diamond_rounded,
          ),
          const DailyOption(
            title: 'Daily Task',
            icon: Icons.task_alt_rounded,
          ),
          const DailyOption(
            title: 'New Update',
            icon: Icons.campaign_rounded,
          ),
        ],
      ),
    );
  }
}

// COMMON BOX DESIGN

BoxDecoration profileBoxDecoration() {
  return BoxDecoration(
    color: white,
    borderRadius: BorderRadius.circular(25),
    boxShadow: [
      BoxShadow(
        color: black.withOpacity(0.16),
        blurRadius: 9,
        offset: const Offset(0, 5),
      ),
    ],
  );
}

// PROFILE SCREEN

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String username = 'Username';
  String bio = '';
  String? gender;
  String? country;
  Uint8List? dpBytes;

  final Map<String, String> countryFlags = const {
    'United Arab Emirates': '🇦🇪',
    'Pakistan': '🇵🇰',
    'India': '🇮🇳',
    'Saudi Arabia': '🇸🇦',
    'Bangladesh': '🇧🇩',
    'Afghanistan': '🇦🇫',
    'Nepal': '🇳🇵',
    'Sri Lanka': '🇱🇰',
    'United Kingdom': '🇬🇧',
    'United States': '🇺🇸',
    'Qatar': '🇶🇦',
    'Oman': '🇴🇲',
    'Kuwait': '🇰🇼',
    'Turkey': '🇹🇷',
    'Canada': '🇨🇦',
  };

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedDp = prefs.getString('profile_dp');

    if (!mounted) return;

    setState(() {
      username = prefs.getString('profile_name') ?? 'Username';
      if (username.trim().isEmpty) username = 'Username';
      bio = prefs.getString('profile_bio') ?? '';
      gender = prefs.getString('profile_gender');
      country = prefs.getString('profile_country');
      dpBytes = encodedDp == null ? null : base64Decode(encodedDp);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool showGender = gender == 'Male' || gender == 'Female';
    final Color genderColor = gender == 'Male'
        ? const Color(0xFF2585E8)
        : const Color(0xFFE85A9B);

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 25),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: OutlinedButton.icon(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const EditProfileScreen(),
                  ),
                );
                loadProfile();
              },
              icon: const Icon(Icons.edit_rounded, size: 17, color: black),
              label: const Text(
                'Edit Profile',
                style: TextStyle(
                  color: black,
                  fontWeight: FontWeight.w800,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: gold, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 17,
                  vertical: 10,
                ),
              ),
            ),
          ),
          const SizedBox(height: 18),
          Container(
            width: 112,
            height: 112,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(colors: [white, grey]),
              border: Border.all(color: gold, width: 2.5),
              boxShadow: [
                BoxShadow(
                  color: black.withOpacity(0.18),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: dpBytes == null
                ? const Icon(Icons.person_rounded, size: 66, color: black)
                : Image.memory(dpBytes!, fit: BoxFit.cover),
          ),
          const SizedBox(height: 13),
          Text(
            username,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: black,
              fontSize: 23,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'ID: 12345678',
            style: TextStyle(
              color: Color(0xFF777777),
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (showGender || country != null) ...[
            const SizedBox(height: 10),
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 13,
              children: [
                if (showGender)
                  Icon(
                    gender == 'Male'
                        ? Icons.male_rounded
                        : Icons.female_rounded,
                    color: genderColor,
                    size: 25,
                  ),
                if (country != null)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        countryFlags[country] ?? '🌍',
                        style: const TextStyle(fontSize: 21),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        country!,
                        style: const TextStyle(
                          color: black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ],
          if (bio.trim().isNotEmpty) ...[
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: Text(
                bio,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: black,
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
            ),
          ],
          const SizedBox(height: 30),
          Row(
            children: [
              ProfileStat(title: 'Followers', count: '0'),
              const ProfileStatDivider(),
              ProfileStat(title: 'Following', count: '0'),
              const ProfileStatDivider(),
              ProfileStat(title: 'Visitors', count: '0'),
              const ProfileStatDivider(),
              ProfileStat(title: 'Gift', count: '0'),
            ],
          ),
          const SizedBox(height: 15),
          Container(
            height: 1,
            width: double.infinity,
            color: const Color(0xFFCCCCCC),
          ),
        ],
      ),
    );
  }
}

// EDIT PROFILE PAGE

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  String? selectedGender;
  String? selectedCountry;
  DateTime? selectedDate;

  Uint8List? selectedDpBytes;
  Uint8List? dpPreviewBytes;

  String originalName = '';
  DateTime? lastNameChange;
  bool isLoading = true;
  bool isSaving = false;

  final ImagePicker imagePicker = ImagePicker();

  final List<String> countries = [
    'United Arab Emirates',
    'Pakistan',
    'India',
    'Saudi Arabia',
    'Bangladesh',
    'Afghanistan',
    'Nepal',
    'Sri Lanka',
    'United Kingdom',
    'United States',
    'Qatar',
    'Oman',
    'Kuwait',
    'Turkey',
    'Canada',
  ];

  final Map<String, String> countryFlags = const {
    'United Arab Emirates': '🇦🇪',
    'Pakistan': '🇵🇰',
    'India': '🇮🇳',
    'Saudi Arabia': '🇸🇦',
    'Bangladesh': '🇧🇩',
    'Afghanistan': '🇦🇫',
    'Nepal': '🇳🇵',
    'Sri Lanka': '🇱🇰',
    'United Kingdom': '🇬🇧',
    'United States': '🇺🇸',
    'Qatar': '🇶🇦',
    'Oman': '🇴🇲',
    'Kuwait': '🇰🇼',
    'Turkey': '🇹🇷',
    'Canada': '🇨🇦',
  };

@override
void initState() {
  super.initState();
  loadProfileData();
  recoverLostDp();
}

  
  Future<void> loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    final savedDob = prefs.getString('profile_dob');
    final encodedDp = prefs.getString('profile_dp');
    final changedAt = prefs.getInt('profile_name_changed_at');

    if (!mounted) return;

    setState(() {
      originalName = prefs.getString('profile_name') ?? '';
      nameController.text = originalName;
      bioController.text = prefs.getString('profile_bio') ?? '';
      selectedGender = prefs.getString('profile_gender');
      selectedCountry = prefs.getString('profile_country');
      selectedDate = savedDob == null ? null : DateTime.tryParse(savedDob);
      selectedDpBytes = encodedDp == null ? null : base64Decode(encodedDp);
      lastNameChange = changedAt == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(changedAt);
      isLoading = false;
    });
  }


Future<void> recoverLostDp() async {
  try {
    final response = await imagePicker.retrieveLostData();
    if (response.isEmpty || !mounted) return;
    final file = response.files?.first;
    if (file == null) return;
    await cropAndPreview(file.path);
  } catch (e) {
    debugPrint('DP recovery error: $e');
  }
}

Future<void> chooseDp() async {
  try {
    final picked = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 95,
    );
    if (picked == null || !mounted) return;
    await cropAndPreview(picked.path);
  } catch (e) {
    debugPrint('DP picker error: $e');
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Unable to open photo. Please try again.')),
    );
  }
}


Future<void> cropAndPreview(String path) async {
  if (!mounted) return;
  try {
    final croppedBytes = await Navigator.push<Uint8List>(
      context,
      MaterialPageRoute(builder: (_) => DpCropScreen(imagePath: path)),
    );
    if (croppedBytes == null || croppedBytes.isEmpty || !mounted) return;
    setState(() => dpPreviewBytes = croppedBytes);
  } catch (e) {
    debugPrint('DP crop screen error: $e');
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Unable to crop photo. Please try again.')),
    );
  }
}

  Future<void> chooseDate() async {
    final today = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? today,
      firstDate: DateTime(1900),
      lastDate: today,
      helpText: 'Select Date of Birth',
    );
    if (picked != null && mounted) {
      setState(() => selectedDate = picked);
    }
  }

  void showComingSoon(String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
    content: Text('$title coming soon'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> saveProfile() async {
    if (isSaving) return;

    final newName = nameController.text.trim();
    final newBio = bioController.text.trim();
    final words = newBio.isEmpty
        ? 0
        : newBio.split(RegExp(r'\s+')).length;

    if (newName.length > 30) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Name can be up to 30 characters.'),
        ),
      );
      return;
    }

    if (words > 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Bio can contain up to 200 words.'),
        ),
      );
      return;
    }

    final bool nameChanged = newName != originalName;

    if (nameChanged && lastNameChange != null) {
      final remaining = const Duration(hours: 24) -
          DateTime.now().difference(lastNameChange!);

      if (remaining > Duration.zero) {
        final hours = remaining.inHours;
        final minutes = remaining.inMinutes.remainder(60);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'You can change your name again in ${hours}h ${minutes}m.',
            ),
          ),
        );
        return;
      }
    }

    setState(() => isSaving = true);

    try {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString('profile_name', newName);
      await prefs.setString('profile_bio', newBio);

      if (selectedGender == null) {
        await prefs.remove('profile_gender');
      } else {
        await prefs.setString('profile_gender', selectedGender!);
      }

      if (selectedCountry == null) {
        await prefs.remove('profile_country');
      } else {
        await prefs.setString('profile_country', selectedCountry!);
      }

      if (selectedDate == null) {
        await prefs.remove('profile_dob');
      } else {
        await prefs.setString(
          'profile_dob',
          selectedDate!.toIso8601String(),
        );
      }

      if (selectedDpBytes == null) {
        await prefs.remove('profile_dp');
      } else {
        await prefs.setString(
          'profile_dp',
          base64Encode(selectedDpBytes!),
        );
      }

      if (nameChanged) {
        await prefs.setInt(
          'profile_name_changed_at',
          DateTime.now().millisecondsSinceEpoch,
        );
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile saved successfully!'),
        ),
      );

      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Save failed: $e')),
      );
    } finally {
      if (mounted) {
        setState(() => isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: gold),
        ),
      );
    }

    final bool nameLocked = lastNameChange != null &&
        DateTime.now().difference(lastNameChange!) <
            const Duration(hours: 24);

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        foregroundColor: black,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: black,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              white,
              Color(0xFFF7F7F7),
              Color(0xFFE1E1E1),
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(18, 15, 18, 30),
          child: Column(
            children: [
              // PROFILE PHOTO

              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 22),
                padding: const EdgeInsets.all(18),
                decoration: profileBoxDecoration(),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 68,
                          height: 68,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: gold, width: 2),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: (dpPreviewBytes ?? selectedDpBytes) == null
                              ? const Icon(
                                  Icons.person,
                                  size: 40,
                                  color: black,
                                )
                              : Image.memory(
                                  dpPreviewBytes ?? selectedDpBytes!,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Profile Photo',
                                style: TextStyle(
                                  color: black,
                                  fontSize: 19,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                height: 42,
                                child: ElevatedButton.icon(
                                  onPressed: chooseDp,
                                  icon: const Icon(
                                    Icons.camera_alt_rounded,
                                    color: black,
                                  ),
                                  label: const Text(
                                    'Change DP',
                                    style: TextStyle(
                                      color: black,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: gold,
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(13),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    if (dpPreviewBytes != null) ...[
                      const SizedBox(height: 16),
                      const Text(
                        'Confirm your new profile photo',
                        style: TextStyle(
                          color: black,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                setState(() {
                                  selectedDpBytes = dpPreviewBytes;
                                  dpPreviewBytes = null;
                                });
                              },
                              icon: const Icon(Icons.check, color: white),
                              label: const Text(
                                'Confirm',
                                style: TextStyle(
                                  color: white,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF218838),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                setState(() {
                                  dpPreviewBytes = null;
                                });
                              },
                              icon: const Icon(Icons.close, color: white),
                              label: const Text(
                                'Cancel',
                                style: TextStyle(
                                  color: white,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFC62828),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),

              // CHANGE NAME

              ProfileInputBox(
                title: 'Change Name',
                icon: Icons.person_rounded,
                child: TextField(
                  controller: nameController,
                  readOnly: nameLocked,
                  maxLength: 30,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(30),
                  ],
                  style: const TextStyle(
                    color: black,
                    fontWeight: FontWeight.w700,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter your name',
                    border: InputBorder.none,
                    counterText: '',
                    helperText: nameLocked
                        ? 'Name change available after 24 hours'
                        : 'Maximum 30 characters',
                    hintStyle: const TextStyle(
                      color: Color(0xFF999999),
                    ),
                  ),
                ),
              ),

              // BIO

              ProfileInputBox(
                title: 'Bio (up to 200 words)',
                icon: Icons.description_rounded,
                child: TextField(
                  controller: bioController,
                  maxLines: 5,
                  minLines: 3,
                  inputFormatters: [
                    const MaxWordsInputFormatter(200),
                  ],
                  style: const TextStyle(
                    color: black,
                    fontWeight: FontWeight.w700,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Write something about yourself (maximum 200 words)',
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Color(0xFF999999)),
                  ),
                ),
              ),

              // GENDER

              ProfileInputBox(
                title: 'Gender',
                icon: Icons.wc_rounded,
                child: Row(
                  children: [
                    Expanded(
                      child: GenderChoice(
                        title: 'Male',
                        icon: Icons.male_rounded,
                        color: const Color(0xFF2585E8),
                        selected: selectedGender == 'Male',
                        onTap: () => setState(
                          () => selectedGender = 'Male',
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: GenderChoice(
                        title: 'Female',
                        icon: Icons.female_rounded,
                        color: const Color(0xFFE85A9B),
                        selected: selectedGender == 'Female',
                        onTap: () => setState(
                          () => selectedGender = 'Female',
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: GenderChoice(
                        title: 'None',
                        icon: Icons.remove_circle_outline_rounded,
                        color: const Color(0xFF888888),
                        selected: selectedGender == 'None',
                        onTap: () => setState(
                          () => selectedGender = 'None',
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // DATE OF BIRTH

              ProfileInputBox(
                title: 'Date of Birth',
                icon: Icons.calendar_month_rounded,
                child: Row(
                  children: [
                    Expanded(
                      child: DatePartChoice(
                        title: selectedDate == null
                            ? 'Date'
                            : '${selectedDate!.day}/${selectedDate!.month}',
                        icon: Icons.calendar_today_rounded,
                        onTap: chooseDate,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: DatePartChoice(
                        title: selectedDate == null
                            ? 'Year'
                            : '${selectedDate!.year}',
                        icon: Icons.event_rounded,
                        onTap: chooseDate,
                      ),
                    ),
                  ],
                ),
              ),

              // COUNTRY

              ProfileInputBox(
                title: 'Country',
                icon: Icons.public_rounded,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedCountry,
                    isExpanded: true,
                    hint: const Text(
                      'Select Country',
                      style: TextStyle(color: Color(0xFF999999)),
                    ),
                    items: countries.map((country) {
                      return DropdownMenuItem(
                        value: country,
                        child: Row(
                          children: [
                            Text(
                              countryFlags[country] ?? '🌍',
                              style: const TextStyle(fontSize: 20),
                            ),
                            const SizedBox(width: 9),
                            Expanded(
                              child: Text(
                                country,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() => selectedCountry = value);
                    },
                  ),
                ),
              ),

              // SAVE BUTTON (MOVED HERE)

              const SizedBox(height: 8),

              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton.icon(
                  onPressed: isSaving ? null : saveProfile,
                  icon: const Icon(
                    Icons.save_rounded,
                    color: black,
                  ),
                  label: Text(
                    isSaving ? 'Saving...' : 'Save',
                    style: const TextStyle(
                      color: black,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: gold,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // PROFILE COLLECTION

              const ProfileSectionHeading(
                title: 'Profile Collection',
              ),

              EditProfileOption(
                title: 'Frame',
                icon: Icons.crop_square_rounded,
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DpCollectionScreen(kind: DpCollectionKind.frames))),
              ),

              EditProfileOption(
                title: 'Themes',
                icon: Icons.wallpaper_rounded,
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DpCollectionScreen(kind: DpCollectionKind.themes))),
              ),

              EditProfileOption(
                title: 'Ornament',
                icon: Icons.auto_awesome_rounded,
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DpCollectionScreen(kind: DpCollectionKind.ornaments))),
              ),

              const SizedBox(height: 12),

              // BADGES

              const ProfileSectionHeading(
                title: 'Badges',
              ),

              EditProfileOption(
                title: 'Entry',
                icon: Icons.login_rounded,
                onTap: () => showComingSoon('Entry'),
              ),

              EditProfileOption(
                title: 'Crown',
                icon: Icons.workspace_premium_rounded,
                onTap: () => showComingSoon('Crown'),
              ),

              EditProfileOption(
                title: 'Game Badge',
                icon: Icons.sports_esports_rounded,
                onTap: () => showComingSoon('Game Badge'),
              ),

              EditProfileOption(
                title: 'Money Badge',
                icon: Icons.paid_rounded,
                onTap: () => showComingSoon('Money Badge'),
              ),

              EditProfileOption(
                title: 'Gift Badge',
                icon: Icons.card_giftcard_rounded,
                onTap: () => showComingSoon('Gift Badge'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// DP CROP SCREEN (PINCH ZOOM + ONE-FINGER MOVE + SLIDER)
class DpCropScreen extends StatefulWidget {
  final String imagePath;
  const DpCropScreen({super.key, required this.imagePath});

  @override
  State<DpCropScreen> createState() => _DpCropScreenState();
}


class _DpCropScreenState extends State<DpCropScreen> {
  final GlobalKey _cropKey = GlobalKey();
  double _zoom = 1.0;
  double _startZoom = 1.0;
  double _baseWidth = 0;
  double _baseHeight = 0;
  Offset _offset = Offset.zero;
  Offset _startOffset = Offset.zero;
  Offset _startFocal = Offset.zero;
  double _viewportSide = 0;
  bool _loading = true;
  bool _saving = false;
  String? _error;


  @override
  void initState() {
    super.initState();
    _prepareImage();
  }


  Future<void> _prepareImage() async {
    try {
      final bytes = await File(widget.imagePath).readAsBytes();
      final codec = await ui.instantiateImageCodec(bytes);
      final frame = await codec.getNextFrame();
      final image = frame.image;
      final w = image.width.toDouble();
      final h = image.height.toDouble();
      image.dispose();
      codec.dispose();
      if (!mounted) return;
      setState(() {
        _baseWidth = w;
        _baseHeight = h;
        _loading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = 'This photo could not be opened.';
      });
    }
  }


  double get _coverScale {
    if (_viewportSide <= 0 || _baseWidth <= 0 || _baseHeight <= 0) return 1;
    return _viewportSide / (_baseWidth < _baseHeight ? _baseWidth : _baseHeight);
  }


  Offset _clampOffset(Offset value, double zoom) {
    if (_viewportSide <= 0 || _baseWidth <= 0 || _baseHeight <= 0) return Offset.zero;
    final scaledW = _baseWidth * _coverScale * zoom;
    final scaledH = _baseHeight * _coverScale * zoom;
    final maxX = ((scaledW - _viewportSide) / 2).clamp(0.0, double.infinity);
    final maxY = ((scaledH - _viewportSide) / 2).clamp(0.0, double.infinity);
    return Offset(
      value.dx.clamp(-maxX, maxX).toDouble(),
      value.dy.clamp(-maxY, maxY).toDouble(),
    );
  }


  void _onScaleStart(ScaleStartDetails details) {
    _startZoom = _zoom;
    _startOffset = _offset;
    _startFocal = details.localFocalPoint;
  }


  void _onScaleUpdate(ScaleUpdateDetails details) {
    // Pan and pinch are one combined gesture. Always calculate from the gesture
    // start snapshot, preventing accumulated drift/jumps between update frames.
    final nextZoom = (_startZoom * details.scale).clamp(1.0, 5.0).toDouble();
    final ratio = nextZoom / _startZoom;
    final center = Offset(_viewportSide / 2, _viewportSide / 2);
    final focalDelta = details.localFocalPoint - _startFocal;
    final imagePointFromCenter = _startFocal - center - _startOffset;
    final zoomShift = imagePointFromCenter * (1.0 - ratio);
    final nextOffset = _startOffset + focalDelta + zoomShift;
    setState(() {
      _zoom = nextZoom;
      _offset = _clampOffset(nextOffset, nextZoom);
    });
  }


  void _onSliderChanged(double value) {
    final ratio = value / _zoom;
    final center = Offset(_viewportSide / 2, _viewportSide / 2);
    final nextOffset = _offset * ratio;
    setState(() {
      _zoom = value;
      _offset = _clampOffset(nextOffset, value);
    });
  }


  Future<void> _confirmCrop() async {
    if (_saving) return;
    setState(() => _saving = true);
    try {
      final boundary = _cropKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) throw StateError('Crop preview is not ready');
      final image = await boundary.toImage(pixelRatio: 2);
      final data = await image.toByteData(format: ui.ImageByteFormat.png);
      image.dispose();
      final bytes = data?.buffer.asUint8List();
      if (bytes == null || bytes.isEmpty) throw StateError('Crop export failed');
      if (!mounted) return;
      Navigator.pop(context, bytes);
    } catch (e) {
      debugPrint('Crop export error: $e');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Crop failed. Please adjust and try again.')),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111111),
      appBar: AppBar(
        backgroundColor: const Color(0xFF111111),
        foregroundColor: white,
        title: const Text('Crop Profile Photo', style: TextStyle(fontWeight: FontWeight.w800)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(foregroundColor: gold, side: BorderSide(color: gold), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              onPressed: _saving ? null : () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(fontWeight: FontWeight.w800)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(foregroundColor: gold, side: BorderSide(color: gold), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              onPressed: _loading || _saving || _error != null ? null : _confirmCrop,
              child: Text(_saving ? 'Saving...' : 'Done', style: const TextStyle(fontWeight: FontWeight.w900)),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: _loading
            ? const Center(child: CircularProgressIndicator(color: gold))
            : _error != null
                ? Center(child: Text(_error!, style: const TextStyle(color: white)))
                : LayoutBuilder(builder: (context, constraints) {
                    final side = (constraints.maxWidth - 24).clamp(220.0, 600.0).toDouble();
                    _viewportSide = side;
                    final imageW = _baseWidth * _coverScale * _zoom;
                    final imageH = _baseHeight * _coverScale * _zoom;
                    return Column(
                      children: [
                        const SizedBox(height: 12),
                        Expanded(
                          child: Center(
                            child: SizedBox(
                              width: side,
                              height: side,
                              child: Stack(
                                children: [
                                  RepaintBoundary(
                                    key: _cropKey,
                                    child: ClipRect(
                                      child: SizedBox(
                                        width: side,
                                        height: side,
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Transform.translate(
                                              offset: _offset,
                                              child: SizedBox(
                                                width: imageW,
                                                height: imageH,
                                                child: Image.file(File(widget.imagePath), fit: BoxFit.fill),
                                              ),
                                            ),
                                            GestureDetector(
                                              behavior: HitTestBehavior.translucent,
                                              onScaleStart: _onScaleStart,
                                              onScaleUpdate: _onScaleUpdate,
                                              child: const SizedBox.expand(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  IgnorePointer(
                                    child: CustomPaint(
                                      size: Size(side, side),
                                      painter: _CropCornersPainter(color: gold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(18, 12, 18, 22),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Pinch to zoom • Drag to move  ${_zoom.toStringAsFixed(2)}×', style: const TextStyle(color: white, fontWeight: FontWeight.w800)),
                              Slider(
                                value: _zoom,
                                min: 1,
                                max: 5,
                                activeColor: gold,
                                inactiveColor: Colors.white24,
                                onChanged: _onSliderChanged,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
      ),
    );
  }
}


class _CropCornersPainter extends CustomPainter {
  final Color color;
  _CropCornersPainter({required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = color..strokeWidth = 4..style = PaintingStyle.stroke..strokeCap = StrokeCap.square;
    const length = 28.0;
    final w = size.width;
    final h = size.height;
    final corners = [
      [Offset.zero, Offset(length, 0), Offset(0, length)],
      [Offset(w, 0), Offset(w - length, 0), Offset(w, length)],
      [Offset(0, h), Offset(length, h), Offset(0, h - length)],
      [Offset(w, h), Offset(w - length, h), Offset(w, h - length)],
    ];
    for (final c in corners) {
      canvas.drawLine(c[0], c[1], p);
      canvas.drawLine(c[0], c[2], p);
    }
  }
  @override
  bool shouldRepaint(covariant _CropCornersPainter oldDelegate) => oldDelegate.color != color;
}


// DP COLLECTION CATALOGS
const List<String> dpFrameNames = [
  'Celestial Halo','Aurora Veil','Velvet Eclipse','Crystal Haven','Royal Aether','Lunar Crest','Opal Cascade','Mystic Bloom','Stardust Relic','Golden Reverie',
  'Sapphire Embrace','Eternal Frost','Phoenix Aura','Diamond Solstice','Twilight Seraph','Imperial Mirage','Radiant Arc','Nebula Crown','Enchanted Ivy','Cosmic Sanctuary',
  'Silver Whisper','Amber Majesty','Scarlet Horizon','Celestial Garden','Frosted Elegance','Astral Symphony','Moonlit Palace','Prism Sanctuary','Heavenly Echo','Obsidian Grace',
  'Aurora Symphony','Emerald Dynasty','Mystic Aurora','Dawn of Glory','Sapphire Tempest','Velvet Sanctuary','Crystal Monarch','Radiant Blossom','Starborn Legacy','Twilight Garden',
  'Golden Solstice','Ethereal Charm','Lunar Majesty','Infinity Bloom','Royal Stardust','Cosmic Jewel','Frostfall Dream','Heaven\'s Embrace','Arcane Radiance','Eternal Blossom',
];
const List<String> dpThemeNames = [
  'Sakura Dreamscape','Midnight Ocean','Desert Mirage','Arctic Serenity','Neon Metropolis','Rosewood Garden','Galaxy Drift','Autumn Whispers','Oceanic Breeze','Lavender Skies',
  'Crimson Rain','Emerald Forest','Cloud Kingdom','Starlit Desert','Cherry Blossom Path','Frozen Aurora','Sunset Boulevard','Tropical Paradise','Moonstone Valley','Cosmic Nebula',
  'Golden Dunes','Misty Highlands','Blue Lagoon','Dreamy Pastel','Shadow Realm','Celestial Voyage','Rainy Tokyo','Wildflower Meadow','Silver Moonlight','Enchanted Waterfall',
  'Phoenix Valley','Winter Wonderland','Crystal Mountains','Mystic River','Heavenly Clouds','Twilight Forest','Solar Flare','Butterfly Haven','Starry Nightfall','Velvet Sunset',
];
const List<String> dpOrnamentNames = [
  'Feathered Grace','Azure Wings','Blooming Vine','Frost Petals','Solar Feathers','Moonbeam Tassel','Crystal Leaves','Whispering Wings','Rosevine Trail','Stardrop Charm',
  'Golden Filigree','Arctic Branch','Butterfly Drift','Celestial Ribbon','Emerald Tendrils','Diamond Sprig','Velvet Plumes','Mystic Lantern','Aurora Branches','Phoenix Feathers',
  'Floral Whirl','Sapphire Strings','Ivy Spiral','Snowflake Trail','Angelic Plumes','Cosmic Threads','Blossom Cascade','Radiant Arrows','Twilight Petals','Silver Fern',
];

enum DpCollectionKind { frames, themes, ornaments }

class DpCollectionScreen extends StatefulWidget {
  final DpCollectionKind kind;
  const DpCollectionScreen({super.key, required this.kind});

  @override
  State<DpCollectionScreen> createState() => _DpCollectionScreenState();
}


class _DpCollectionScreenState extends State<DpCollectionScreen> {
  int selected = -1;

  String get heading => switch (widget.kind) {
    DpCollectionKind.frames => 'DP Frames',
    DpCollectionKind.themes => 'DP Themes',
    DpCollectionKind.ornaments => 'DP Ornaments',
  };
  List<String> get names => switch (widget.kind) {
    DpCollectionKind.frames => dpFrameNames,
    DpCollectionKind.themes => dpThemeNames,
    DpCollectionKind.ornaments => dpOrnamentNames,
  };
  final List<Color> colors = const [
    Color(0xFFB98722), Color(0xFF7B5BD6), Color(0xFF1F91C8), Color(0xFFE15C91),
    Color(0xFF3D9B72), Color(0xFFCC5739), Color(0xFF6074C9), Color(0xFF9A6B4C),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        foregroundColor: black,
        centerTitle: true,
        title: Text(heading, style: const TextStyle(fontWeight: FontWeight.w900)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: const Color(0xFFFFF6D9), borderRadius: BorderRadius.circular(16), border: Border.all(color: gold)),
              child: Text('${names.length} designs • UI preview only', textAlign: TextAlign.center, style: const TextStyle(color: black, fontWeight: FontWeight.w800)),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 18),
              itemCount: names.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: widget.kind == DpCollectionKind.frames ? 4 : 2, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: widget.kind == DpCollectionKind.themes ? 1.0 : widget.kind == DpCollectionKind.ornaments ? 2.25 : 0.78),
              itemBuilder: (context, index) {
                final accent = colors[index % colors.length];
                final isSelected = selected == index;
                return InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => setState(() => selected = index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(color: isSelected ? const Color(0xFFFFF4D3) : white, borderRadius: BorderRadius.circular(16), border: Border.all(color: isSelected ? gold : const Color(0xFFE0E0E0), width: isSelected ? 2 : 1), boxShadow: [BoxShadow(color: black.withOpacity(0.08), blurRadius: 4, offset: const Offset(0, 2))]),
                    child: Column(
                      children: [
                        Expanded(child: _catalogPreview(kind: widget.kind, index: index, accent: accent)),
                        const SizedBox(height: 6),
                        Text(names[index], maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center, style: const TextStyle(color: black, fontSize: 10.5, fontWeight: FontWeight.w800)),
                        if (isSelected) const Padding(padding: EdgeInsets.only(top: 2), child: Icon(Icons.check_circle, size: 14, color: Color(0xFF218838))),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          if (selected >= 0)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              decoration: const BoxDecoration(color: white, border: Border(top: BorderSide(color: Color(0xFFE1E1E1)))),
              child: Text('Selected: ${names[selected]}  •  Preview only', textAlign: TextAlign.center, style: const TextStyle(color: black, fontWeight: FontWeight.w800)),
            ),
        ],
      ),
    );
  }

  Widget _catalogPreview({required DpCollectionKind kind, required int index, required Color accent}) {
    if (kind == DpCollectionKind.themes) {
      final other = colors[(index + 3) % colors.length];
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), gradient: LinearGradient(colors: [accent.withOpacity(0.85), other.withOpacity(0.8), const Color(0xFF202033)], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: Stack(children: [Positioned(right: -8, top: -8, child: Icon(Icons.blur_on, size: 54, color: white.withOpacity(0.18))), Center(child: Icon([Icons.nightlight_round, Icons.water, Icons.landscape, Icons.ac_unit, Icons.location_city, Icons.local_florist, Icons.auto_awesome][index % 7], color: white, size: 28))]),
      );
    }
    if (kind == DpCollectionKind.ornaments) {
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(color: const Color(0xFFF7F7F7), borderRadius: BorderRadius.circular(12)),
        child: Stack(alignment: Alignment.center, children: [
          Container(width: 45, height: 45, decoration: BoxDecoration(shape: BoxShape.circle, color: white, border: Border.all(color: const Color(0xFFCCCCCC)))),
          Positioned(left: 5, top: 7 + (index % 3) * 3, child: Icon([Icons.eco, Icons.auto_awesome, Icons.local_florist, Icons.flutter_dash, Icons.waves][index % 5], color: accent, size: 19)),
          Positioned(right: 5, bottom: 7 + (index % 3) * 3, child: Icon([Icons.star, Icons.spa, Icons.diamond, Icons.brightness_5, Icons.park][(index + 2) % 5], color: accent.withOpacity(0.8), size: 17)),
        ]),
      );
    }
    final ringWidth = 1.5 + (index % 4) * 0.7;
    final ringStyle = index % 3;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: const Color(0xFFF8F8F8), borderRadius: BorderRadius.circular(12)),
      child: Center(
        child: Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: accent, width: ringWidth, style: ringStyle == 1 ? BorderStyle.none : BorderStyle.solid), boxShadow: [BoxShadow(color: accent.withOpacity(0.28), blurRadius: 6)]),
          child: Container(
            margin: EdgeInsets.all(2 + (index % 4)),
            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: colors[(index + 1) % colors.length], width: 1 + (index % 2)),
              gradient: index % 4 == 0 ? LinearGradient(colors: [accent.withOpacity(0.25), white]) : null),
            child: Icon(index % 5 == 0 ? Icons.star : index % 5 == 1 ? Icons.diamond : index % 5 == 2 ? Icons.auto_awesome : index % 5 == 3 ? Icons.local_florist : Icons.circle, size: 18, color: accent.withOpacity(0.8)),
          ),
        ),
      ),
    );
  }
}


// MAX WORDS FORMATTER

class MaxWordsInputFormatter extends TextInputFormatter {
  final int maxWords;

  const MaxWordsInputFormatter(this.maxWords);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.trim();
    final words = text.isEmpty ? 0 : text.split(RegExp(r'\s+')).length;

    return words <= maxWords ? newValue : oldValue;
  }
}

// GENDER CHOICE

class GenderChoice extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final bool selected;
  final VoidCallback onTap;

  const GenderChoice({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(13),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 4,
        ),
        decoration: BoxDecoration(
          color: selected ? color.withOpacity(0.12) : const Color(0xFFF7F7F7),
          borderRadius: BorderRadius.circular(13),
          border: Border.all(
            color: selected ? color : const Color(0xFFE2E2E2),
            width: selected ? 1.6 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 25),
            const SizedBox(height: 4),
            FittedBox(
              child: Text(
                title,
                style: const TextStyle(
                  color: black,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// DATE CHOICE

class DatePartChoice extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const DatePartChoice({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(13),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 13,
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F7F7),
          borderRadius: BorderRadius.circular(13),
          border: Border.all(
            color: const Color(0xFFE2E2E2),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: gold, size: 19),
            const SizedBox(width: 7),
            Flexible(
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: black,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// EDIT PROFILE INPUT BOX

class ProfileInputBox extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;

  const ProfileInputBox({
    super.key,
    required this.title,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 22),
      padding: const EdgeInsets.fromLTRB(20, 17, 20, 15),
      decoration: profileBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ProfileGoldIcon(icon: icon),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: black,
                    fontSize: 19,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: child,
          ),
        ],
      ),
    );
  }
}

// EDIT PROFILE OPTION BOX

class EditProfileOption extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const EditProfileOption({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 22),
      decoration: profileBoxDecoration(),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(28),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Row(
              children: [
                ProfileGoldIcon(icon: icon),
                const SizedBox(width: 19),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: black,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: black,
                  size: 21,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// GOLD ICON DESIGN

class ProfileGoldIcon extends StatelessWidget {
  final IconData icon;

  const ProfileGoldIcon({
    super.key,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 49,
      height: 49,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFFFE9A8),
            gold,
            Color(0xFFD99A00),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFC18B00),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: black.withOpacity(0.20),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Icon(icon, color: black, size: 28),
    );
  }
}

// SECTION HEADING

class ProfileSectionHeading extends StatelessWidget {
  final String title;

  const ProfileSectionHeading({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, top: 5),
      child: Row(
        children: [
          Container(
            width: 5,
            height: 25,
            decoration: BoxDecoration(
              color: gold,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(
              color: black,
              fontSize: 21,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

// WELCOME CARD

class WelcomeCard extends StatelessWidget {
  const WelcomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(27),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF393939),
            Color(0xFF171717),
            Color(0xFF050505),
          ],
        ),
        border: Border.all(color: gold, width: 2),
        boxShadow: [
          BoxShadow(
            color: black.withOpacity(0.45),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned(
            right: -25,
            top: -25,
            child: Icon(
              Icons.workspace_premium,
              size: 190,
              color: gold.withOpacity(0.09),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(19, 23, 8, 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome to',
                  style: TextStyle(
                    color: white,
                    fontSize: 23,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                const Text.rich(
                  TextSpan(
                    style: TextStyle(
                      fontSize: 39,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                      letterSpacing: -2,
                    ),
                    children: [
                      TextSpan(
                        text: 'Play',
                        style: TextStyle(color: white),
                      ),
                      TextSpan(
                        text: 'Zupi',
                        style: TextStyle(color: gold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Play Together\nConnect Forever',
                  style: TextStyle(
                    color: white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    height: 1.35,
                  ),
                ),
                const Spacer(),
                Container(
                  width: 95,
                  height: 3,
                  decoration: BoxDecoration(
                    color: gold,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
          ),
          const Positioned(
            right: 8,
            top: 35,
            child: Column(
              children: [
                Icon(
                  Icons.workspace_premium,
                  color: gold,
                  size: 60,
                ),
                SizedBox(height: 5),
                Icon(
                  Icons.sports_esports_rounded,
                  color: gold,
                  size: 85,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// DAILY OPTION BOXES

class DailyOption extends StatelessWidget {
  final String title;
  final IconData icon;

  const DailyOption({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            white,
            Color(0xFFFDFDFD),
            Color(0xFFE5E5E5),
          ],
        ),
        border: Border.all(
          color: const Color(0xFFEEEEEE),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: black.withOpacity(0.40),
            blurRadius: 17,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: white.withOpacity(0.9),
            blurRadius: 4,
            offset: const Offset(-2, -2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(28),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('$title coming soon'),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Row(
              children: [
                ProfileGoldIcon(icon: icon),
                const SizedBox(width: 19),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: black,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: black,
                  size: 21,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// OTHER TABS

class OtherTabScreen extends StatelessWidget {
  final String title;
  final IconData icon;

  const OtherTabScreen({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [white, grey],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: black.withOpacity(0.30),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Icon(icon, color: black, size: 55),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              color: black,
              fontSize: 30,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

// PROFILE STAT

class ProfileStat extends StatelessWidget {
  final String title;
  final String count;

  const ProfileStat({
    super.key,
    required this.title,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            count,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}

// PROFILE STAT DIVIDER

class ProfileStatDivider extends StatelessWidget {
  const ProfileStatDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 1,
      color: const Color(0xFFCCCCCC),
    );
  }
}
  
