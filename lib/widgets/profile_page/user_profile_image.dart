import 'package:firebase_login/constants/colors.dart';
import 'package:firebase_login/stores/query_store.dart';
import 'package:firebase_login/stores/user_store.dart';
import 'package:firebase_login/widgets/circle_avatar/circle_avatar_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class UserProfileImage extends StatefulWidget {
  final Color profileBackgroundColor;
  final Color refreshIndicatorBackgroundColor;
  final Color refreshIndicatorCircularColor;
  final bool isEditMode;

  UserProfileImage({
    this.profileBackgroundColor = CustomColors.backGroundColor,
    this.refreshIndicatorBackgroundColor = CustomColors.primaryColor,
    this.refreshIndicatorCircularColor = CustomColors.backGroundColor,
    this.isEditMode = false,
  });
  @override
  _UserProfileImageState createState() => _UserProfileImageState();
}

class _UserProfileImageState extends State<UserProfileImage> {
  bool loading = false;
  double targetHeight;
  double targetWidth;
  UserStore _userStore;
  QueryStore _queryStore;

  @override
  void initState() {
    super.initState();
    _userStore = context.read();
    _queryStore = context.read();
  }

  Widget _userProfileImage() {
    return FlatButton(
      onPressed: widget.isEditMode
          ? () async {
              setState(() => loading = true);
              await _userStore.updateProfilePic();
              setState(() => loading = false);
            }
          : null,
      child: Column(
        children: [
          Container(
            height: targetHeight / 8,
            width: targetHeight / 8,
            child: loading
                ? Center(
                    child: CircularProgressIndicator(
                      backgroundColor: widget.refreshIndicatorBackgroundColor,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          widget.refreshIndicatorCircularColor),
                    ),
                  )
                : Container(
                    child: CircleAvatarImage(
                        color: widget.profileBackgroundColor,
                        imageURL: _userStore.getAuth?.currentUser?.photoURL,
                        text:
                            '-' //'${(_userStore.getAuth?.currentUser?.displayName.split(' ')[0] ?? '-'.substring(0, 2)) ?? '-'.toUpperCase()}',
                        ),
                  ),
          ),
          SizedBox(height: 5),
          widget.isEditMode
              ? Text(
                  'Change profile image',
                  textAlign: TextAlign.center,
                )
              : Container(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    targetHeight = MediaQuery.of(context).size.height;
    targetWidth = MediaQuery.of(context).size.width;
    return Observer(
      builder: (_) {
        return _userProfileImage();
      },
    );
  }
}
