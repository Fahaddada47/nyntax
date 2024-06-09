import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nyntax/features/controller/vehicle_controller.dart';
import 'package:nyntax/features/ui/screens/additional_charges_screen.dart';
import 'package:nyntax/features/ui/widget/custome_text_filed.dart';
import 'package:nyntax/features/ui/widget/text_styles.dart';
import '../../model/vehicle_model.dart' as vehicle_model;

class VehicleInfoScreen extends StatefulWidget {
  @override
  _VehicleInfoScreenState createState() => _VehicleInfoScreenState();
}

class _VehicleInfoScreenState extends State<VehicleInfoScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? selectedVehicleType;
  final TextEditingController vehicleModelController = TextEditingController();
  final VehicleController vehicleController = Get.find();
  final box = GetStorage();
  vehicle_model.Data? selectedVehicle;

  void searchVehicle() {
    setState(() {
      selectedVehicle = vehicleController.vehicle.value.data?.firstWhereOrNull(
        (vehicle) =>
            vehicle.type == selectedVehicleType &&
            vehicle.model!.toLowerCase() ==
                vehicleModelController.text.toLowerCase(),
      );
    });
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
                  border: Border.all(color: const Color(0xFFD7D7FF)),
                ),
                child: buildForm(),
              ),
              const SizedBox(height: 24),
              buildObx(),
              const SizedBox(height: 105),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      box.write('vehicleType', selectedVehicleType);
                      box.write('vehicleModel', selectedVehicle!.model);
                      box.write('weeklyCharge', selectedVehicle!.rates!.weekly);
                      box.write('dailyCharge', selectedVehicle!.rates!.daily);
                      box.write('hourlyCharge', selectedVehicle!.rates!.hourly);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                      Get.to(const AdditionalChargesScreen());
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

  Obx buildObx() {
    return Obx(() {
      if (vehicleController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

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
                    // Image.network(
                    //   selectedVehicle!.imageURL.toString(),
                    //   width: 163,
                    //   height: 85,
                    // ),
                    CachedNetworkImage(
                      width: 163,
                      height: 85,
                      imageUrl: selectedVehicle!.imageURL.toString(),
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    const SizedBox(width: 16.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${selectedVehicle!.make} ${selectedVehicle!.model}',
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
                              '${selectedVehicle!.seats} seats',
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
                              '${selectedVehicle!.bags} bags',
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
                    '\$${selectedVehicle!.rates!.hourly} / Hour',
                    style: getTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Mulish',
                        color: const Color(0xff6F6F6F)),
                  ),
                  Text(
                    '\$${selectedVehicle!.rates!.daily} / Day',
                    style: getTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Mulish',
                        color: const Color(0xff6F6F6F)),
                  ),
                  Text(
                    '\$${selectedVehicle!.rates!.weekly} / Week',
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
    });
  }

  Form buildForm() {
    return Form(
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
                    .toList() ??
                [];

            return SizedBox(
              height: 55,
              child: DropdownButtonFormField<String>(
                focusColor: const Color(0xFFD7D7FF),
                icon: const Icon(Icons.keyboard_arrow_down_outlined),
                value: selectedVehicleType,
                items: vehicleTypes.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: getTextStyle(
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff828290),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedVehicleType = newValue;
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFD7D7FF)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a vehicle type';
                  }
                  return null;
                },
              ),
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
            onSuffixIconPressed: searchVehicle,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a vehicle model';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
