// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../theme/colors.dart';

class ProfileAvatar extends StatelessWidget {
  late String image;
  late String firstlettername;
  late int rad;
  late double? width;
  ProfileAvatar(
      {super.key,
      required this.image,
      required this.firstlettername,
      required this.rad,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: CircleAvatar(
        radius: rad.toDouble(),
        backgroundColor: appAccentColor,
        child: CircleAvatar(
          backgroundColor: appBackgroundColor,
          radius: rad.toDouble() - 2,
          foregroundImage: (image != "null" || image!='') ? NetworkImage(image) : null,
          backgroundImage: NetworkImage(image),
          child: Text(firstlettername[0],
              style: const TextStyle(
                color: appAccentColor,
                fontSize: 30,
              )),
        ),
      ),
    );
  }
}
