import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyntax/features/ui/widget/custome_text_filed.dart';

class VehicleInfoScreen extends StatefulWidget {
  @override
  _VehicleInfoScreenState createState() => _VehicleInfoScreenState();
}

class _VehicleInfoScreenState extends State<VehicleInfoScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? selectedVehicleType = 'Sedan';
  final TextEditingController vehicleModelController = TextEditingController();

  String defaultFontFamily = 'Poppins';

  TextStyle getTextStyle({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    String? fontFamily,
  }) {
    return TextStyle(
      color: color ?? const Color(0xFF1B1B1B),
      fontSize: fontSize ?? 14,
      fontFamily: fontFamily ?? defaultFontFamily,
      fontWeight: fontWeight ?? FontWeight.w300,
    );
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
        title: Text("Back", style: getTextStyle()),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Vehicle Information",
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
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Vehicle Type',
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
                      const SizedBox(height: 8.0),
                      DropdownButtonFormField<String>(
                        icon: const Icon(Icons.keyboard_arrow_down_outlined),
                        value: selectedVehicleType,
                        items: ['Sedan', 'SUV', 'Truck', 'Coupe']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: getTextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xff828290)),
                            ),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            selectedVehicleType = newValue;
                          });
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a vehicle type';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      RichText(
                        text: TextSpan(
                          text: 'Vehicle Model',
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
                      const SizedBox(height: 8.0),
                      CustomTextField(
                        controller: vehicleModelController,
                        labelText: '',
                        suffixIcon: const Icon(Icons.search),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a vehicle model';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 8,  bottom: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Image.network(
                              'https://i.ibb.co/phm75dj/Screenshot-2024-04-14-225804.png',
                              // Replace with actual image URL
                              width: 163,
                              height: 85,
                            ),
                            const SizedBox(width: 16.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Toyota Camry',
                                  style: getTextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Mulish',
                                      color: const Color(0xff333333)),
                                ),
                                const SizedBox(height: 8.0),
                                Row(
                                  children: [
                                    const Icon(Icons.person, size: 16),
                                    const SizedBox(width: 4.0),
                                    Text(
                                      '4 seats',
                                      style: getTextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Mulish',
                                          color: const Color(0xff93909C)),
                                    ),
                                    const SizedBox(width: 16.0),
                                  ],
                                ),
                                const SizedBox(width: 8.0),
                                 Row(
                                  children: [
                                    const Icon(Icons.luggage, size: 16),
                                    const SizedBox(width: 4.0),
                                    Text('3 bags',
                                      style: getTextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Mulish',
                                          color: const Color(0xff93909C)),),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18.0),
                      Container(
                        height: 2,

                        color: const Color(0xFFD7D7FF),
                      ),
                      const SizedBox(height: 4,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            '\$15 / Hour',
                            style: getTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Mulish',
                                color: const Color(0xff6F6F6F)),
                          ),
                          Text(
                            '\$70 / Day',
                            style: getTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Mulish',
                                color: const Color(0xff6F6F6F)),
                          ),
                          Text(
                            '\$250 / Week',
                            style: getTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Mulish',
                                color: const Color(0xff6F6F6F)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 185),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                      // Navigate to the next screen
                    }
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
