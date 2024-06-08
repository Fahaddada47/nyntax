import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nyntax/features/ui/screens/customerinfo_screen.dart';
import 'package:nyntax/features/ui/widget/custome_text_filed.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({super.key});

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  final TextEditingController reservationIdController = TextEditingController();
  final TextEditingController pickupDateController = TextEditingController();
  final TextEditingController returnDateController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final box = GetStorage();

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

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        final DateTime fullDateTime = DateTime(picked.year, picked.month,
            picked.day, pickedTime.hour, pickedTime.minute);
        controller.text = DateFormat('yyyy-MM-dd HH:mm').format(fullDateTime);

        if (pickupDateController.text.isNotEmpty &&
            returnDateController.text.isNotEmpty) {
          _calculateDuration();
        }
      }
    }
  }

  void _calculateDuration() {
    DateTime pickupDate =
        DateFormat('yyyy-MM-dd HH:mm').parse(pickupDateController.text);
    DateTime returnDate =
        DateFormat('yyyy-MM-dd HH:mm').parse(returnDateController.text);

    Duration difference = returnDate.difference(pickupDate);

    int days = difference.inDays;
    int hours = difference.inHours.remainder(24);
    int minutes = difference.inMinutes.remainder(60);

    int weeks = days ~/ 7;
    days = days % 7;

    String durationString = '${weeks} Weeks ${days} Days ${hours} Hours';

    if (minutes > 0) {
      durationString += ' ${minutes}M';
    }

    durationController.text = durationString;
  }

  void _saveData() {
    box.write('reservationId', reservationIdController.text);
    box.write('pickupDate', pickupDateController.text);
    box.write('returnDate', returnDateController.text);
    box.write('duration', durationController.text);
    box.write('discount', discountController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Reservation Details",
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
                  border: Border.all(color: Color(0xFFD7D7FF)),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Reservation ID',
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
                        controller: reservationIdController,
                        labelText: '',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your reservation ID';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 6.0),
                      RichText(
                        text: TextSpan(
                          text: 'Pickup Date',
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
                      GestureDetector(
                        onTap: () => _selectDate(context, pickupDateController),
                        child: AbsorbPointer(
                          child: CustomTextField(
                            controller: pickupDateController,
                            labelText: 'Select Date and Time',
                            keyboardType: TextInputType.datetime,
                            suffixIcon: const Icon(Icons.calendar_today,
                                color: Color(0xFFD7D7FF)),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your pickup date';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      RichText(
                        text: TextSpan(
                          text: 'Return Date',
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
                      GestureDetector(
                        onTap: () => _selectDate(context, returnDateController),
                        child: AbsorbPointer(
                          child: CustomTextField(
                            controller: returnDateController,
                            labelText: 'Select Date and Time',
                            keyboardType: TextInputType.datetime,
                            suffixIcon: const Icon(Icons.calendar_today,
                                color: Color(0xFFD7D7FF)),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your return date';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'Duration',
                              style: getTextStyle(),
                            ),
                          ),
                          Container(
                            height: 45,
                            width: 180,
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              border: Border.all(color: Color(0xFFD7D7FF)),
                            ),
                            child: Center(
                              child: Text(durationController.text,style: getTextStyle(),),
                            ),
                          ),

                        ],
                      ),

                      // CustomTextField(
                      //   controller: durationController,
                      //   labelText: '',
                      //   readOnly: true,
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return 'Please enter the duration';
                      //     }
                      //     return null;
                      //   },
                      // ),
                      const SizedBox(height: 6.0),
                      RichText(
                        text: TextSpan(
                          text: 'Discount',
                          style: getTextStyle(),
                        ),
                      ),

                      CustomTextField(
                        controller: discountController,
                        labelText: '',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your discount';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 6.0),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 80),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _saveData();
                      Get.to(CoustomerInfoScreen());
                      Get.snackbar("", 'Saving Data');
                    }
                  },
                  child: Text(
                    'Next',
                    style: getTextStyle(
                        fontWeight: FontWeight.w600, color: Colors.white),
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
