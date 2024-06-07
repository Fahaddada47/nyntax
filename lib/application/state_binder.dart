import 'package:get/get.dart';
import 'package:nyntax/features/controller/vehicle_controller.dart';
import 'package:nyntax/features/repository/vehicle_repository.dart';


class StateHolderBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(VehicleRepository());
    Get.put(VehicleController(repository: Get.find()));
  }
}
