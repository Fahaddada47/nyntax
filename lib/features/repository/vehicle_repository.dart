import 'package:nyntax/features/model/vehicle_model.dart';
import 'package:nyntax/features/services/network_caller.dart';
import 'package:nyntax/features/services/network_response.dart';
import 'package:nyntax/features/urls/urls.dart';

class VehicleRepository {
  Future<VehicleModel?> fetchVehicles() async {

    NetworkResponse response = await NetworkCaller.getRequest(Urls.vehicle);

    if (response.isSuccess && response.body != null) {
      return VehicleModel.fromJson(response.body!);
    } else {
      return null;
    }
  }
}
