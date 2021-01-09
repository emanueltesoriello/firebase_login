import 'package:firebase_login/constants/assets.dart';
import 'package:firebase_login/constants/colors.dart';
import 'package:firebase_login/stores/query_store.dart';
import 'package:firebase_login/stores/upload_profile_store.dart';
import 'package:firebase_login/stores/user_store.dart';
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
  UploadProfileStore uploadProfileStore;
  bool showPencil = false;

  @override
  void initState() {
    super.initState();
    _userStore = context.read();
    _queryStore = context.read();
    uploadProfileStore = context.read();
  }

  Widget _userProfileImage() {
    return Container(
      child: InkWell(
        customBorder: CircleBorder(),
        onHover: (hover) {
          print(hover);
          if (widget.isEditMode) {
            if (hover) {
              setState(() => showPencil = true);
            } else {
              setState(() => showPencil = false);
            }
          }
        },
        onTap: widget.isEditMode
            ? () async {
                setState(() => loading = true);
                print("before");
                uploadProfileStore.selectFile().then(
                    (value) => uploadProfileStore.uploadImage().then((value) {
                          print(value);
                          _userStore.updateProfilePic(value);
                          setState(() => loading = false);
                        }));
              }
            : null,
        child: loading
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: widget.refreshIndicatorBackgroundColor,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      widget.refreshIndicatorCircularColor),
                ),
              )
            : Stack(
                children: [
                  showPencil
                      ? ClipOval(
                          child: ColorFiltered(
                            colorFilter: ColorFilter.mode(
                                Colors.grey[700], BlendMode.modulate),
                            child: Image.network(
                                _userStore
                                        .getAuth?.currentUser?.photoURL !=
                                    null
                                ? _userStore.getAuth?.currentUser?.photoURL
                                : Assets.emptyUserPic),
                          ),
                        )
                      : ClipOval(
                          child: Image.network(_userStore
                                      .getAuth?.currentUser?.photoURL !=
                                  null
                              ? _userStore.getAuth?.currentUser?.photoURL
                              : Assets.emptyUserPic),
                        ),
                  showPencil
                      ? Positioned.fill(
                          child: Align(
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.mode_edit,
                                color: Colors.white,
                              )),
                        )
                      : Container(),
                ],
              ),
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
