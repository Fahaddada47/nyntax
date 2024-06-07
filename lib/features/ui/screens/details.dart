import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nyntax/features/ui/widget/detail_container.dart';

class DisplayReservationScreen extends StatefulWidget {
  const DisplayReservationScreen({super.key});

  @override
  State<DisplayReservationScreen> createState() =>
      _DisplayReservationScreenState();
}

class _DisplayReservationScreenState extends State<DisplayReservationScreen> {
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
    dynamic firstName = box.read('firstName')?.toString() ?? '';
    dynamic lastName = box.read('lastName')?.toString() ?? '';
    dynamic email = box.read('email')?.toString() ?? '';
    dynamic phone = box.read('phone')?.toString() ?? '';
    dynamic reservationId = box.read('reservationId')?.toString() ?? '';
    dynamic pickupDate = box.read('pickupDate')?.toString() ?? '';
    dynamic returnDate = box.read('returnDate')?.toString() ?? '';
    dynamic vehicleType = box.read('vehicleType')?.toString() ?? '';
    dynamic vehicleModel = box.read('vehicleModel')?.toString() ?? '';
    dynamic weeklyCharge = box.read('weeklyCharge')?.toString() ?? '';
    dynamic hourlyCharge = box.read('hourlyCharge')?.toString() ?? '';
    dynamic dailyCharge = box.read('dailyCharge')?.toString() ?? '';
    dynamic selectedTitles = box.read('selectedTitles')?.toString() ?? '';
    dynamic selectedValues = box.read('selectedValues')?.toString() ?? '';
    dynamic netTotal = box.read('netTotal')?.toString() ?? '';

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
            DetailContainer(details: [
              {'label': 'Weekly (1 week)', 'value': weeklyCharge},
              {'label': 'Daily (2 days)', 'value': dailyCharge},
              {'label': selectedTitles, 'value': selectedValues},
            ]),

            // DataTable(
            //   columns: [
            //     DataColumn(label: Text('Charge', style: getTextStyle())),
            //     DataColumn(label: Text('Total', style: getTextStyle())),
            //   ],
            //   rows: [
            //     DataRow(cells: [
            //       DataCell(Text('Weekly (1 week)', style: getTextStyle())),
            //       DataCell(Text(weeklyCharge, style: getTextStyle())),
            //     ]),
            //     DataRow(cells: [
            //       DataCell(Text('Daily (2 days)', style: getTextStyle())),
            //       DataCell(Text(dailyCharge, style: getTextStyle())),
            //     ]),
            //     DataRow(cells: [
            //       DataCell(Text(selectedTitles, style: getTextStyle())),
            //       DataCell(Text(selectedValues, style: getTextStyle())),
            //     ]),
            //   ],
            // ),
            const SizedBox(height: 16),
            Text("Net Total: $netTotal",
                style: getTextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
