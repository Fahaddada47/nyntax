import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nyntax/features/ui/widget/detail_container.dart';
import 'package:nyntax/features/ui/widget/text_styles.dart';

class DisplayReservationScreen extends StatefulWidget {
  const DisplayReservationScreen({super.key});

  @override
  State<DisplayReservationScreen> createState() =>
      _DisplayReservationScreenState();
}

class _DisplayReservationScreenState extends State<DisplayReservationScreen> {
  final box = GetStorage();

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
    dynamic weeklyCharge = box.read('weeklyCharge')?.toString() ?? '0';
    dynamic hourlyCharge = box.read('hourlyCharge')?.toString() ?? '0';
    dynamic dailyCharge = box.read('dailyCharge')?.toString() ?? '0';
    dynamic discount = box.read('discount')?.toString() ?? '0';
    dynamic duration = box.read('duration')?.toString() ?? '';
    List<dynamic> selectedTitlesDynamic = box.read('selectedTitles') ?? [];
    List<dynamic> selectedValuesDynamic = box.read('selectedValues') ?? [];

    List<String> selectedTitles =
        List<String>.from(selectedTitlesDynamic.map((e) => e.toString()));
    List<String> selectedValues =
        List<String>.from(selectedValuesDynamic.map((e) => e.toString()));

    List<String> durationParts = duration.split(' ');
    int weeks = 0;
    int days = 0;
    int hours = 0;

    if (durationParts.isNotEmpty) {
      weeks = int.tryParse(durationParts[0].replaceAll('W', '')) ?? 0;
    }
    if (durationParts.length > 1) {
      days = int.tryParse(durationParts[1].replaceAll('D', '')) ?? 0;
    }
    if (durationParts.length > 2) {
      hours = int.tryParse(durationParts[2].replaceAll('H', '')) ?? 0;
    }

    double totalWeeklyCharge = weeks * double.parse(weeklyCharge);
    double totalDailyCharge = days * double.parse(dailyCharge);
    double totalHourlyCharge = hours * double.parse(hourlyCharge);
    double discountValue = double.parse(discount);

    double totalSelectedValues = 0;
    List<Map<String, String>> selectedItems = [];

    for (int i = 0; i < selectedTitles.length; i++) {
      String valueStr = selectedValues[i];
      double value;
      if (valueStr.endsWith('%')) {
        double percentage = double.parse(valueStr.replaceAll('%', '')) / 100;
        value = percentage *
            (totalWeeklyCharge + totalDailyCharge + totalHourlyCharge);
      } else {
        value = double.parse(valueStr);
      }
      totalSelectedValues += value;
      selectedItems
          .add({'label': selectedTitles[i], 'value': value.toStringAsFixed(2)});
    }

    double netTotal = totalWeeklyCharge +
        totalDailyCharge +
        totalHourlyCharge +
        totalSelectedValues -
        discountValue;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_sharp),
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
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFE5E5FF),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFF5D5CFF)),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Charge',
                          style: getTextStyle(fontWeight: FontWeight.w600)),
                      Text('Total',
                          style: getTextStyle(fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const Divider(color: Color(0xFF5D5CFF)),
                  const SizedBox(height: 8),
                  Column(
                    children: [
                      _buildChargeRow(
                          'Weekly (${weeks} week${weeks > 1 ? 's' : ''})',
                          totalWeeklyCharge),
                      _buildChargeRow(
                          'Daily (${days} day${days > 1 ? 's' : ''})',
                          totalDailyCharge),
                      _buildChargeRow(
                          'Hourly (${hours} hour${hours > 1 ? 's' : ''})',
                          totalHourlyCharge),
                      for (var item in selectedItems)
                        _buildChargeRow(
                            item['label']!, double.parse(item['value']!)),
                      _buildChargeRow('Discount', -discountValue),
                    ],
                  ),
                  const Divider(color: Color(0xFF5D5CFF)),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Net Total:',
                          style: getTextStyle(fontWeight: FontWeight.w600)),
                      Text('\$${netTotal.toStringAsFixed(2)}',
                          style: getTextStyle(fontWeight: FontWeight.w600)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChargeRow(String label, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: getTextStyle()),
          Text('\$${value.toStringAsFixed(2)}', style: getTextStyle()),
        ],
      ),
    );
  }
}
