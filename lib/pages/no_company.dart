import 'package:firebase_login/constants/colors.dart';
import 'package:firebase_login/stores/query_store.dart';
import 'package:firebase_login/widgets/buttons/do_you_have_magic_code_button.dart';
import 'package:firebase_login/widgets/buttons/save_new_company_button.dart';
import 'package:firebase_login/widgets/decorations/generic_rounded_button_decoration.dart';
import 'package:firebase_login/widgets/textfields/chamber_of_commerce_textformfield.dart';
import 'package:firebase_login/widgets/textfields/company_name_textformfield.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class NoCompany extends StatefulWidget {
  final String title;
  final String description;
  final bool enableMagicCode;
  final String imageURL;
  final Color backgroundColor;
  final Color buttonColor;
  final Color buttonSplashColor;
  final Color buttonDisabledColor;
  final String backgroundImageAsset;

  NoCompany({
    this.title = 'Welcome!',
    this.description =
        "Please create a new company or join an existing one using the Magic Code!",
    this.enableMagicCode = false,
    this.imageURL =
        'https://marketinggenius.nl/wp-content/uploads/2020/09/Marketing_Genius_Raket-Circle_BLAUW_500-1280x1280.png',
    this.backgroundColor = Colors.white,
    this.buttonColor = CustomColors.primaryColor,
    this.buttonSplashColor = CustomColors.backGroundColor,
    this.buttonDisabledColor = Colors.grey,
    this.backgroundImageAsset = 'web/images/desktop_background.jpg',
  });

  @override
  _NoCompanyState createState() => _NoCompanyState();
}

class _NoCompanyState extends State<NoCompany> {
  double targetWidth;
  double targetHeight;
  QueryStore _queryStore;

  @override
  void initState() {
    super.initState();
    _queryStore = context.read();
  }

  Widget _buildCompanyVatTextField() {
    return Container(
      width: targetWidth / 1.12,
      child: ChamberOfCommerceTextFormField(
          //decoration: textfieldInputDecoration('Chamber of Commerce no.'),
          ),
    );
  }

  Widget _buildCompanyNameTextField() {
    return Container(
      width: targetWidth / 1.12,
      child: CompanyNameTextFormField(
          // decoration: textfieldInputDecoration('Company name'),
          ),
    );
  }

  Widget _saveButton() {
    return Container(
      height: targetHeight / 16,
      width: targetWidth / 1.2,
      child: GenericRoundedButtonDecoration(
        buttonColor: widget.buttonColor,
        splashColor: widget.buttonSplashColor,
        disabledColor: widget.buttonDisabledColor,
        child: SaveButton(),
      ),
    );
  }

  showMessage() {
    Future.delayed(Duration(milliseconds: 0), () {
      FlushbarHelper.createInformation(
        message: _queryStore.errorStore.errorMessage,
        title: 'Attention!',
        duration: Duration(seconds: 5),
      )..show(context);
    });

    return SizedBox.shrink();
  }

  Widget _titleAndSubtitle() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(widget.title,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: targetHeight / 40)),
      SizedBox(height: 5),
      Text(widget.description, style: TextStyle(height: 1.5)),
    ]);
  }

  Widget _magicCodeSection() {
    return Container(
      child: Column(
        children: [
          Text('Or are joining a company?'),
          Container(height: targetHeight / 50, width: targetWidth),
          Container(
            height: targetHeight / 16,
            width: targetWidth / 1.2,
            child: GenericRoundedButtonDecoration(
              buttonColor: widget.buttonColor,
              splashColor: widget.buttonSplashColor,
              disabledColor: widget.buttonDisabledColor,
              child: DoYouHaveMagicCodeButton(),
            ),
          ),
          targetWidth > 890.0
              ? Container()
              : Container(height: targetHeight / 20),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      height: targetHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(height: targetHeight / 20),
                  FadeInImage.memoryNetwork(
                    height: targetHeight / 5,
                    placeholder: kTransparentImage,
                    image: widget.imageURL,
                  ),
                  targetWidth > 890.0
                      ? SizedBox(height: 5)
                      : Container(height: targetHeight / 30),
                  _titleAndSubtitle(),
                  targetWidth > 890.0
                      ? SizedBox(height: 5)
                      : Container(height: targetHeight / 30),
                  _buildCompanyVatTextField(),
                  targetWidth > 890.0
                      ? SizedBox(height: 5)
                      : Container(height: targetHeight / 30),
                  _buildCompanyNameTextField(),
                  targetWidth > 890.0
                      ? SizedBox(height: 5)
                      : Container(height: targetHeight / 30),
                  _saveButton()
                ]),
          ),
          MediaQuery.of(context).viewInsets.bottom == 0
              ? widget.enableMagicCode
                  ? _magicCodeSection()
                  : Container()
              : Container(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    targetWidth = deviceWidth;
    targetHeight = deviceHeight;
    return Observer(
      builder: (_) {
        if (_queryStore.errorStore.errorMessage.isNotEmpty) {
          print(_queryStore.errorStore.errorMessage);
          showMessage();
        }
        print(targetWidth);
        return Scaffold(
          backgroundColor: widget.backgroundColor,
          body: SingleChildScrollView(
              child: targetWidth > 890.0
                  ? Container(
                      width: targetWidth,
                      height: targetHeight,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(widget.backgroundImageAsset))),
                      child: Center(
                        child: Container(
                            color: Colors.white,
                            width: targetWidth > 1920.0
                                ? targetWidth / 5
                                : targetWidth / 3,
                            height: targetHeight / 1.3,
                            padding: const EdgeInsets.all(25),
                            alignment: Alignment.center,
                            child: _buildBody()),
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.only(
                        left: targetHeight / 30,
                        right: targetHeight / 30,
                        top: targetHeight / 30,
                        // bottom: targetHeight / 20
                      ),
                      child: _buildBody())),
        );
      },
    );
  }
}
