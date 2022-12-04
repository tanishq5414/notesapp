// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notesapp/features/auth/controller/auth_controller.dart';
import 'package:notesapp/theme/colors.dart';
import 'package:notesapp/features/settings/components/profiledisplay.dart';
import 'package:routemaster/routemaster.dart';


import '../components/custom_appbar.dart';
import 'components/display_tile.dart';
import 'components/sideheading.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final user = ref.watch(userProvider);
    void signOut() {
      ref.read(authControllerProvider.notifier).signOut(context);
      Routemaster.of(context).push('/');
    }

    void deleteAccount() {
      ref.read(authControllerProvider.notifier).deleteAccount(context);
    }

    final String name = user?.name ?? 'Companioner';
    final String email = user?.email ?? "update your email";
    final firstlettername = name[0];
    var size = MediaQuery.of(context).size;
    // final appAccentColor = Theme.of(context).accentColor;
    return Container(
      color: appBackgroundColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: appBackgroundColor,
          appBar: CustomAppBar(
            title: "Settings",
          ),
          body: Padding(
            padding: EdgeInsets.all(size.width * 0.02),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: size.width * 0.07),
                    child: InkWell(
                      onTap: () {
                        Routemaster.of(context).push('/editprofile');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ProfileAvatar(
                            image: user?.photoUrl.toString() ?? "null",
                            firstlettername: firstlettername,
                            rad: 38,
                            width: size.width*0.2,
                          ),
                          SizedBox(
                            width: size.width * 0.05,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: const TextStyle(
                                  color: appWhiteColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              const Text('Edit Profile',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: appWhiteColor,
                                  )),
                            ],
                          ),
                          Spacer(),
                          const Icon(Icons.arrow_forward_ios_rounded,
                              color: appWhiteColor),
                        ],
                      ),
                    ),
                  ),
                  DisplayTile(
                    title: 'Customize',
                    subtitle: 'Change the accent color',
                    trailing: Icon(
                      Icons.color_lens,
                      color: appAccentColor,
                    ),
                  ),
                  DisplayTile(
                    title: 'Notifications',
                    subtitle: 'Turn on/off notifications',
                    trailing: Icon(
                      Icons.notifications_none,
                      color: appAccentColor,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  SideHeading(
                    title: "Account",
                  ),
                  DisplayTile(
                    title: 'Premium plan',
                    subtitle: 'View your plan',
                    onpressed: () {
                      Routemaster.of(context).push('/premium');
                    },
                  ),
                  DisplayTile(
                    title: 'Email',
                    subtitle: email,
                    onpressed: () {
                      Routemaster.of(context).push('/changeemail');
                    },
                  ),
                  DisplayTile(
                    title: 'Password',
                    subtitle: 'Change your password',
                    onpressed: () {
                      Routemaster.of(context).push('/changepassword');
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  SideHeading(title: 'About'),
                  DisplayTile(
                    title: 'Version',
                    subtitle: '1.0.0',
                    onpressed: () {
                      Routemaster.of(context).push('/about');

                    },
                  ),
                  DisplayTile(
                    title: 'Privacy policy',
                    subtitle: 'View our privacy policy',
                    onpressed: () {
                      Routemaster.of(context).push('/privacypolicy');
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  SideHeading(title: 'Others'),
                  DisplayTile(
                    title: 'Log out',
                    subtitle: 'Currently logged in as $name',
                    onpressed: () {
                      signOut();
                    },
                  ),
                  DisplayTile(
                      title: 'Delete Account',
                      subtitle: 'This action is irreversible',
                      onpressed: () {
                        deleteAccount();
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
