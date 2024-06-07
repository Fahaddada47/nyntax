import 'package:get/get.dart';
import 'package:nyntax/features/model/vehicle_model.dart';
import 'package:nyntax/features/repository/vehicle_repository.dart';

class VehicleController extends GetxController {
  var vehicle = VehicleModel().obs;
  var isLoading = true.obs;

  final VehicleRepository repository;

  VehicleController({required this.repository});

  @override
  void onInit() {
    fetchVehicles();
    super.onInit();
  }

  void fetchVehicles() async {
    isLoading(true);
    try {
      var fetchedVehicle = await repository.fetchVehicles();
      if (fetchedVehicle != null) {
        vehicle.value = fetchedVehicle;
      }
    } finally {
      isLoading(false);
    }
  }
}
