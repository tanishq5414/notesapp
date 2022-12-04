import 'dart:async';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notesapp/core/error_text.dart';
import 'package:notesapp/features/auth/controller/auth_controller.dart';
import 'package:notesapp/modal/user_modal.dart';
import 'package:notesapp/router.dart';
import 'package:notesapp/theme/colors.dart';
import 'package:notesapp/features/components/snack_bar.dart';
import 'package:routemaster/routemaster.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString("email");
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => ProviderScope(
          child: MyApp(
        email: email,
      )),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  var email;

  MyApp({required this.email, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  UserCollection? userModel;

  void getData(WidgetRef ref, User data) async {
    userModel = await ref
        .watch(authControllerProvider.notifier)
        .getUserData(data.uid)
        .first;
    ref.read(userProvider.notifier).update((state) => userModel);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(authStateProvider).when(
          loading: () => const CircularProgressIndicator(),
          error: (error, stackTrace) => ErrorText(error: error.toString()),
          data: (data) => MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Montserrat',
              primaryColor: Colors.black,
              scaffoldBackgroundColor: appBackgroundColor,
              textSelectionTheme: const TextSelectionThemeData(
                cursorColor: appBlackColor,
                selectionColor: appAccentColor,
                selectionHandleColor: Colors.black,
              ),
              primarySwatch: primaryBlack,
            ),
            scaffoldMessengerKey: Utils.messengerKey,
            routeInformationParser: const RoutemasterParser(),
            routerDelegate: RoutemasterDelegate(
              routesBuilder: (context) {
                if (data != null) {
                  getData(ref, data);
                  if (userModel != null) {
                  return loggedInPages;
                  }
                }
                return loggedOutPages;
              },
            ),
          ),
        );
  }
}
