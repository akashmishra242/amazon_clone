// ignore_for_file: use_build_context_synchronously
import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/constants/global_app_constants.dart';
import 'package:amazon_clone/features/authentication/controller/auth_controller.dart';
import 'package:amazon_clone/features/homePage/screen/home_screen.dart';
import 'package:amazon_clone/features/homePage/screen/landing_screen.dart';
import 'package:amazon_clone/models/user_model.dart';
import 'package:amazon_clone/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/home_page_controller.dart';

enum Edit {
  password,
  otherDetails,
}

class EditUserDetails extends ConsumerStatefulWidget {
  static const routeName = '/edit-user-details';
  const EditUserDetails({super.key});

  @override
  ConsumerState<EditUserDetails> createState() => _EditUserDetailsState();
}

class _EditUserDetailsState extends ConsumerState<EditUserDetails> {
  Edit _edit = Edit.otherDetails;
  final TextEditingController _fullNameEditingController =
      TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _phoneEditingController = TextEditingController();
  final TextEditingController _pincodeEditingController =
      TextEditingController();
  final TextEditingController _cityEditingController = TextEditingController();
  final TextEditingController _countryEditingController =
      TextEditingController();
  final TextEditingController _oldpasswordEditingController =
      TextEditingController();
  final TextEditingController _newpasswordEditingController =
      TextEditingController();
  final TextEditingController _confirmNewpasswordEditingController =
      TextEditingController();
  final TextEditingController _addressEditingController =
      TextEditingController();

  final _updateUserDetailsformkey = GlobalKey<FormState>();
  final _upadtePasswordDetailsKey = GlobalKey<FormState>();
  String userHashedOldPassword = '';

  void setTextfieldToKnownData() async {
    UserModel? user = await ref.read(authControllerProvider).getUserDetails();
    _addressEditingController.text = user?.address ?? '';
    _fullNameEditingController.text = user?.fullname ?? '';
    userHashedOldPassword = user?.password ?? '';
    _phoneEditingController.text = user?.phone ?? '';
    _cityEditingController.text = user?.city ?? '';
    _countryEditingController.text = user?.country ?? '';
    _emailEditingController.text = user?.email ?? '';
    _pincodeEditingController.text = user?.pincode ?? '';
  }

  Future<void> updatePassword() async {
    String messageInCaseOfError =
        await ref.read(homePageControllerProvider).updatePassword(
              context: context,
              password: _newpasswordEditingController.text == ''
                  ? null
                  : _newpasswordEditingController.text.trim(),
              confirmnewpassword:
                  _confirmNewpasswordEditingController.text == ''
                      ? null
                      : _confirmNewpasswordEditingController.text.trim(),
              oldpassword: _oldpasswordEditingController.text == ''
                  ? null
                  : _oldpasswordEditingController.text.trim(),
            );
    if (_upadtePasswordDetailsKey.currentState!.validate()) {
      if (messageInCaseOfError == '') {
        Navigator.of(context).pushReplacementNamed(
          LandingScreen.routeName,
        );
      }
    }
  }

  Future<void> updateOtherUserData() async {
    String messageInCaseOfError =
        await ref.read(homePageControllerProvider).updateUserData(
              context: context,
              address: _addressEditingController.text == ''
                  ? null
                  : _addressEditingController.text,
              fullname: _fullNameEditingController.text == ''
                  ? null
                  : _fullNameEditingController.text,
              phone: _phoneEditingController.text == ''
                  ? null
                  : _phoneEditingController.text,
              city: _cityEditingController.text == ''
                  ? null
                  : _cityEditingController.text,
              country: _countryEditingController.text == ''
                  ? null
                  : _countryEditingController.text,
              email: _emailEditingController.text == ''
                  ? null
                  : _emailEditingController.text,
              pincode: _pincodeEditingController.text == ''
                  ? null
                  : _pincodeEditingController.text,
            );

    if (_updateUserDetailsformkey.currentState!.validate()) {
      if (messageInCaseOfError == '') {
        Navigator.of(context).pushReplacementNamed(
          LandingScreen.routeName,
        );
      }
    }
  }

  @override
  void initState() {
    setTextfieldToKnownData();
    super.initState();
  }

  @override
  void dispose() {
    _fullNameEditingController.dispose();
    _emailEditingController.dispose();
    _phoneEditingController.dispose();
    _cityEditingController.dispose();
    _pincodeEditingController.dispose();
    _countryEditingController.dispose();
    _addressEditingController.dispose();
    _oldpasswordEditingController.dispose();
    _newpasswordEditingController.dispose();
    _confirmNewpasswordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: const [],
        toolbarHeight: MediaQuery.of(context).size.height * 0.08,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: GlobalVariables.otherAppBarGradient,
          ),
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Positioned(
                  left: 0,
                  child: Image.asset(
                    'assets/images/mylogo_wbg.png',
                    scale: 5.5,
                    color: Colors.black,
                  )),
            ],
          ),
        ),
      ),
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            decoration: BoxDecoration(color: GlobalVariables.backgroundColor),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16),
                  decoration: BoxDecoration(
                      gradient: GlobalVariables.otherAppBarGradient),
                  child: Row(
                    children: const [
                      Text(
                        'Edit User Details',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                ListTile(
                  tileColor: _edit == Edit.password
                      ? GlobalVariables.backgroundColor
                      : GlobalVariables.greyBackgroundCOlor,
                  title: const Text(
                    'Change Password',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: Radio(
                      activeColor: GlobalVariables.secondaryColor,
                      value: Edit.password,
                      groupValue: _edit,
                      onChanged: (Edit? val) {
                        setState(() {
                          _edit = val!;
                        });
                      }),
                ),
                if (_edit == Edit.password)
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: GlobalVariables.backgroundColor,
                    child: Form(
                      key: _upadtePasswordDetailsKey,
                      child: Column(
                        children: [
                          CustomTextField(
                              controller: _oldpasswordEditingController,
                              obsecure: false,
                              showCancelIcon: true,
                              showValidator: true,
                              showlabeltext: true,
                              labeltext: 'old password*',
                              hintText: 'Enter your old password *'),
                          const SizedBox(height: 10),
                          CustomTextField(
                              controller: _newpasswordEditingController,
                              obsecure: true,
                              showCancelIcon: true,
                              showValidator: true,
                              showlabeltext: true,
                              labeltext: 'new password*',
                              hintText: 'Enter your new password *'),
                          const SizedBox(height: 10),
                          CustomTextField(
                              controller: _confirmNewpasswordEditingController,
                              obsecure: true,
                              showCancelIcon: true,
                              showValidator: true,
                              showlabeltext: true,
                              labeltext: 'confirm new password*',
                              hintText: 'Confirm new password *'),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 10),
                ListTile(
                  tileColor: _edit == Edit.otherDetails
                      ? GlobalVariables.backgroundColor
                      : GlobalVariables.greyBackgroundCOlor,
                  title: const Text(
                    'User Information',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: Radio(
                      activeColor: GlobalVariables.secondaryColor,
                      value: Edit.otherDetails,
                      groupValue: _edit,
                      onChanged: (Edit? val) {
                        setState(() {
                          _edit = val!;
                        });
                      }),
                ),
                if (_edit == Edit.otherDetails)
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: GlobalVariables.backgroundColor,
                    child: Form(
                      key: _updateUserDetailsformkey,
                      child: Column(
                        children: [
                          CustomTextField(
                              controller: _fullNameEditingController,
                              showCancelIcon: true,
                              showlabeltext: true,
                              showValidator: true,
                              labeltext: 'fullname*',
                              hintText: 'Your Fullname *'),
                          const SizedBox(height: 10),
                          CustomTextField(
                              controller: _emailEditingController,
                              showCancelIcon: true,
                              showlabeltext: true,
                              showValidator: true,
                              labeltext: 'email*',
                              hintText: 'Your new email *'),
                          const SizedBox(height: 10),
                          CustomTextField(
                              controller: _phoneEditingController,
                              showValidator: true,
                              showCancelIcon: true,
                              showlabeltext: true,
                              labeltext: 'phone*',
                              hintText: 'Your new phone number *'),
                          const SizedBox(height: 10),
                          CustomTextField(
                              controller: _addressEditingController,
                              showCancelIcon: true,
                              showlabeltext: true,
                              hintText: 'Enter address'),
                          const SizedBox(height: 10),
                          CustomTextField(
                              controller: _cityEditingController,
                              showCancelIcon: true,
                              showlabeltext: true,
                              hintText: 'Enter city'),
                          const SizedBox(height: 10),
                          CustomTextField(
                              controller: _pincodeEditingController,
                              showCancelIcon: true,
                              showlabeltext: true,
                              hintText: 'Enter pincode'),
                          const SizedBox(height: 10),
                          CustomTextField(
                              controller: _countryEditingController,
                              showCancelIcon: true,
                              showlabeltext: true,
                              hintText: 'Enter Country'),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 10),
                Text('* fields are mandatory',
                    style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(height: 10),
                CustomButton(
                    text: 'Update',
                    onTap: (() {
                      _edit == Edit.password
                          ? updatePassword()
                          : updateOtherUserData();
                    }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
