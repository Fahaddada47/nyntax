import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyntax/features/controller/vehicle_controller.dart';
import 'package:nyntax/features/ui/widget/custome_text_filed.dart';
import '../../model/vehicle_model.dart';

class VehicleInfoScreen extends StatefulWidget {
  @override
  _VehicleInfoScreenState createState() => _VehicleInfoScreenState();
}

class _VehicleInfoScreenState extends State<VehicleInfoScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? selectedVehicleType;
  final TextEditingController vehicleModelController = TextEditingController();
  final VehicleController vehicleController = Get.find();

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
                      Obx(() {
                        if (vehicleController.isLoading.value) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        List<String> vehicleTypes = vehicleController.vehicle.value.data
                            ?.map((vehicle) => vehicle.type)
                            .where((type) => type != null)
                            .toSet()
                            .cast<String>()
                            .toList() ?? [];

                        return DropdownButtonFormField<String>(
                          icon: const Icon(Icons.keyboard_arrow_down_outlined),
                          value: selectedVehicleType,
                          items: vehicleTypes.map((String value) {
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
                        );
                      }),
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
              Obx(() {
                if (vehicleController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                Data? selectedVehicle = vehicleController.vehicle.value.data?.firstWhereOrNull(
                        (vehicle) => vehicle.type == selectedVehicleType || vehicle.model == vehicleModelController.text);

                if (selectedVehicle == null) {
                  return const Center(child: Text('No vehicle selected'));
                }

                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Image.network(
                                selectedVehicle.imageURL.toString(),
                                width: 163,
                                height: 85,
                              ),
                              const SizedBox(width: 16.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${selectedVehicle.make} ${selectedVehicle.model}',
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
                                        '${selectedVehicle.seats} seats',
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
                                      Text(
                                        '${selectedVehicle.bags} bags',
                                        style: getTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Mulish',
                                            color: const Color(0xff93909C)),
                                      ),
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
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              '\$${selectedVehicle.rates!.hourly} / Hour',
                              style: getTextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Mulish',
                                  color: const Color(0xff6F6F6F)),
                            ),
                            Text(
                              '\$${selectedVehicle.rates!.daily} / Day',
                              style: getTextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Mulish',
                                  color: const Color(0xff6F6F6F)),
                            ),
                            Text(
                              '\$${selectedVehicle.rates!.weekly} / Week',
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
                );
              }),
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
