import 'package:firebase_login/constants/colors.dart';
import 'package:firebase_login/stores/query_store.dart';
import 'package:firebase_login/stores/user_store.dart';
import 'package:firebase_login/widgets/circle_avatar/circle_avatar_image.dart';
import 'package:firebase_login/widgets/texts/text_default.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopBarWeb extends StatefulWidget {
  final Color color;
  final Widget imageLogo;
  final Color userAvatarColor;
  TopBarWeb(
      {this.color = CustomColors.primaryColor,
      this.imageLogo,
      this.userAvatarColor = CustomColors.backGroundColor});
  @override
  _TopBarWebState createState() => _TopBarWebState();
}

class _TopBarWebState extends State<TopBarWeb> {
  UserStore _userStore;
  double targetHeight;
  double targetWidth;

  @override
  void initState() {
    super.initState();
    _userStore = context.read();
  }

  @override
  Widget build(BuildContext context) {
    targetHeight = MediaQuery.of(context).size.height;
    targetWidth = MediaQuery.of(context).size.width;
    return Container(
      height: targetHeight / 12,
      padding: EdgeInsets.only(left: targetWidth / 20, right: targetWidth / 30),
      decoration: BoxDecoration(
        color: widget.color,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 4,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          widget.imageLogo ?? Container(),
          Container(
            height: targetHeight / 17,
            width: targetHeight / 17,
            child: Container(
              child: CircleAvatarImage(
                color: widget.userAvatarColor,
                imageURL: _userStore.getAuth?.currentUser?.photoURL,
                text:
                    '.'//'${(_userStore.getAuth?.currentUser?.displayName.split(' ')[0] ?? '-'.substring(0, 2)) ?? '-'.toUpperCase()}',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
