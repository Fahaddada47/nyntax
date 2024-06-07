import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class DisplayReservationScreen extends StatelessWidget {
  final box = GetStorage();

  TextStyle getTextStyle({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    String? fontFamily,
  }) {
    return TextStyle(
      color: color ?? const Color(0xFF1B1B1B),
      fontSize: fontSize ?? 14,
      fontFamily: fontFamily ?? 'Poppins',
      fontWeight: fontWeight ?? FontWeight.w300,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve stored data
    String firstName = box.read('firstName') ?? '';
    String lastName = box.read('lastName') ?? '';
    String email = box.read('email') ?? '';
    String phone = box.read('phone') ?? '';
    String reservationId = box.read('reservationId') ?? '';
    String pickupDate = box.read('pickupDate') ?? '';
    String returnDate = box.read('returnDate') ?? '';
    String duration = box.read('duration') ?? '';
    String discount = box.read('discount') ?? '';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_sharp),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
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
            Text("First Name: $firstName", style: getTextStyle()),
            Text("Last Name: $lastName", style: getTextStyle()),
            Text("Email: $email", style: getTextStyle()),
            Text("Phone: $phone", style: getTextStyle()),
            const SizedBox(height: 24),
            Text(
              "Reservation Information",
              style: getTextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Container(
              height: 2,
              color: const Color(0xFF5D5CFF),
            ),
            const SizedBox(height: 24),
            Text("Reservation ID: $reservationId", style: getTextStyle()),
            Text("Pickup Date: $pickupDate", style: getTextStyle()),
            Text("Return Date: $returnDate", style: getTextStyle()),
            Text("Duration: $duration", style: getTextStyle()),
            Text("Discount: $discount", style: getTextStyle()),
          ],
        ),
      ),
    );
  }
}
