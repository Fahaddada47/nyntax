import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nyntax/features/ui/widget/detail_container.dart';

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
    String firstName = box.read('firstName') ?? '';
    String lastName = box.read('lastName') ?? '';
    String email = box.read('email') ?? '';
    String phone = box.read('phone') ?? '';
    String reservationId = box.read('reservationId') ?? '';
    String pickupDate = box.read('pickupDate') ?? '';
    String returnDate = box.read('returnDate') ?? '';
    String vehicleType = box.read('vehicleType') ?? '';
    String vehicleModel = box.read('vehicleModel') ?? '';
    String weeklyCharge = box.read('weeklyCharge') ?? '';
    String dailyCharge = box.read('dailyCharge') ?? '';
    String collisionWaiver = box.read('collisionWaiver') ?? '';
    String netTotal = box.read('netTotal') ?? '';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_sharp),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Back", style: getTextStyle()),
      ),
      body: SingleChildScrollView(
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
            DetailContainer(details: [
              {'label': 'Reservation ID:', 'value': reservationId},
              {'label': 'Pickup Date:', 'value': pickupDate},
              {'label': 'Dropoff Date:', 'value': returnDate},
            ]),
            const SizedBox(height: 24),
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
            DetailContainer(details: [
              {'label': 'First Name:', 'value': firstName},
              {'label': 'Last Name:', 'value': lastName},
              {'label': 'Email:', 'value': email},
              {'label': 'Phone:', 'value': phone},
            ]),
            const SizedBox(height: 24),
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
            DetailContainer(details: [
              {'label': 'Vehicle Type:', 'value': vehicleType},
              {'label': 'Vehicle Model:', 'value': vehicleModel},
            ]),
            const SizedBox(height: 24),
            Text(
              "Charges Summary",
              style: getTextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Container(
              height: 2,
              color: const Color(0xFF5D5CFF),
            ),
            const SizedBox(height: 24),
            DataTable(
              columns: [
                DataColumn(label: Text('Charge', style: getTextStyle())),
                DataColumn(label: Text('Total', style: getTextStyle())),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text('Weekly (1 week)', style: getTextStyle())),
                  DataCell(Text(weeklyCharge, style: getTextStyle())),
                ]),
                DataRow(cells: [
                  DataCell(Text('Daily (2 days)', style: getTextStyle())),
                  DataCell(Text(dailyCharge, style: getTextStyle())),
                ]),
                DataRow(cells: [
                  DataCell(
                      Text('Collision Damage Waiver', style: getTextStyle())),
                  DataCell(Text(collisionWaiver, style: getTextStyle())),
                ]),
              ],
            ),
            const SizedBox(height: 16),
            Text("Net Total: $netTotal",
                style: getTextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
