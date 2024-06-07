import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdditionalChargesScreen extends StatefulWidget {
  @override
  _AdditionalChargesScreenState createState() => _AdditionalChargesScreenState();
}

class _AdditionalChargesScreenState extends State<AdditionalChargesScreen> {
  bool collisionDamageWaiver = false;
  bool liabilityInsurance = false;
  bool rentalTax = false;

  String defaultFontFamily = 'Poppins';

  TextStyle getTextStyle({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    String? fontFamily,
  }) {
    return TextStyle(
      color: color ?? const Color(0xFF000000),
      fontSize: fontSize ?? 14,
      fontFamily: fontFamily ?? defaultFontFamily,
      fontWeight: fontWeight ?? FontWeight.w400,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double padding = size.width * 0.04;
    final double spacing = size.height * 0.03;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_sharp),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text("Back", style: getTextStyle()),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Additional Charges",
                style: getTextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: spacing * 0.5),
              Container(
                height: 2,
                color: const Color(0xFF5D5CFF),
              ),
              SizedBox(height: spacing),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  children: [
                    CheckboxListTile(
                      title: Text(
                        'Collision Damage Waiver',
                        style: getTextStyle(),
                      ),
                      secondary: Text(
                        '\$9.00',
                        style: getTextStyle(),
                      ),
                      value: collisionDamageWaiver,
                      onChanged: (bool? value) {
                        setState(() {
                          collisionDamageWaiver = value ?? false;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: Color(0xFFD7D7FF),
                    ),
                    CheckboxListTile(
                      title: Text(
                        'Liability Insurance',
                        style: getTextStyle(),
                      ),
                      secondary: Text(
                        '\$15.00',
                        style: getTextStyle(),
                      ),
                      value: liabilityInsurance,
                      onChanged: (bool? value) {
                        setState(() {
                          liabilityInsurance = value ?? false;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: Color(0xFFD7D7FF),
                    ),
                    CheckboxListTile(
                      title: Text(
                        'Rental Tax',
                        style: getTextStyle(),
                      ),
                      secondary: Text(
                        '11.5%',
                        style: getTextStyle(),
                      ),
                      value: rentalTax,
                      onChanged: (bool? value) {
                        setState(() {
                          rentalTax = value ?? false;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: Color(0xFFD7D7FF),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.45),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                  },
                  child: Text(
                    'Next',
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