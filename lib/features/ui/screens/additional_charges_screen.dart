import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nyntax/features/ui/screens/details.dart';
import 'package:nyntax/features/ui/widget/check_box_item.dart';

class AdditionalChargesScreen extends StatefulWidget {
  const AdditionalChargesScreen({super.key});

  @override
  _AdditionalChargesScreenState createState() =>
      _AdditionalChargesScreenState();
}

class _AdditionalChargesScreenState extends State<AdditionalChargesScreen> {
  final box = GetStorage();
  String defaultFontFamily = 'Poppins';

  List<CheckboxItem> checkboxItems = [
    CheckboxItem(title: 'Collision Damage Waiver', price: 9.00),
    CheckboxItem(title: 'Liability Insurance', price: 15.00),
    CheckboxItem(title: 'Rental Tax', percentage: 11.5),
  ];

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
          icon: const Icon(Icons.arrow_back_ios_sharp),
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
                  children: checkboxItems.map((item) {
                    return CheckboxListTile(
                      title: Text(
                        item.title,
                        style: getTextStyle(),
                      ),
                      secondary: Text(
                        item.secondaryText,
                        style: getTextStyle(),
                      ),
                      value: item.value,
                      onChanged: (bool? value) {
                        setState(() {
                          item.value = value ?? false;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: const Color(0xFFD7D7FF),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: size.height * 0.45),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    List<String> selectedTitles = [];
                    List<double> selectedValues = [];
                    for (var item in checkboxItems) {
                      if (item.value) {
                        selectedTitles.add(item.title);
                        if (item.price != null) {
                          selectedValues.add(item.price!);
                        } else if (item.percentage != null) {
                          selectedValues.add(item.percentage!);
                        }
                      }
                    }
                    box.write('selectedTitles', selectedTitles);
                    box.write('selectedValues', selectedValues);
                    Get.to(const DisplayReservationScreen());
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
