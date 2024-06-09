import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nyntax/features/ui/screens/vehicle_screen.dart';
import 'package:nyntax/features/ui/widget/custome_text_filed.dart';
import 'package:nyntax/features/ui/widget/text_styles.dart';

class CoustomerInfoScreen extends StatefulWidget {
  @override
  _CoustomerInfoScreenState createState() => _CoustomerInfoScreenState();
}

class _CoustomerInfoScreenState extends State<CoustomerInfoScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final box = GetStorage();

  void _saveData() {
    box.write('firstName', firstNameController.text);
    box.write('lastName', lastNameController.text);
    box.write('email', emailController.text);
    box.write('phone', phoneController.text.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_sharp),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          "Back",
          style: getTextStyle(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Customer Information",
                style: getTextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Container(
                height: 2,
                color: const Color(0xFF5D5CFF),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  border: Border.all(color: const Color(0xFFD7D7FF)),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'First Name',
                          style: getTextStyle(),
                          children: [
                            TextSpan(
                              text: '*',
                              style: getTextStyle(
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustomTextField(
                        controller: firstNameController,
                        labelText: '',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your first name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 6.0),
                      RichText(
                        text: TextSpan(
                          text: 'Last Name',
                          style: getTextStyle(),
                          children: [
                            TextSpan(
                              text: '*',
                              style: getTextStyle(
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustomTextField(
                        controller: lastNameController,
                        labelText: '',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your last name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 6.0),
                      RichText(
                        text: TextSpan(
                          text: 'Email',
                          style: getTextStyle(),
                          children: [
                            TextSpan(
                              text: '*',
                              style: getTextStyle(
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustomTextField(
                        controller: emailController,
                        labelText: '',
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 6.0),
                      RichText(
                        text: TextSpan(
                          text: 'Phone',
                          style: getTextStyle(),
                          children: [
                            TextSpan(
                              text: '*',
                              style: getTextStyle(
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustomTextField(
                        controller: phoneController,
                        labelText: '',
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 6.0),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 120),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _saveData();
                      Get.snackbar("", 'Saving Data');

                      Get.to(VehicleInfoScreen());
                    }
                  },
                  child: Text(
                    'Submit',
                    style: getTextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
