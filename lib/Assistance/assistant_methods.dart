import 'package:geolocator/geolocator.dart';
import 'package:inamari/Assistance/request_assistant.dart';
import 'package:inamari/data%20handler/app_data.dart';
import 'package:inamari/models/address_model.dart';
import 'package:provider/provider.dart';
import 'package:inamari/config_maps.dart';

class AssistantMethods {
  static Future<String> searchCoordinateAddress(
      Position position, context) async {
    String placeAddress = "";
    String st1, st2, st3, st4;
    String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey";
    var response = await RequestAssitant.getRequest(url);

    if (response != "failed") {
      // placeAddress = response["results"][0]["formatted_address"];

      placeAddress =
          st1 = response["results"][0]["address_components"][3]["long_name"];
      st2 = response["results"][0]["address_components"][4]["long_name"];
      st3 = response["results"][0]["address_components"][5]["long_name"];
      st4 = response["results"][0]["address_components"][6]["long_name"];

      placeAddress = "Hargeysa, Somalia";

      Address userPickUpAdress = Address();
      userPickUpAdress.longitude = position.longitude;
      userPickUpAdress.latitude = position.latitude;
      userPickUpAdress.placeName = placeAddress;

      Provider.of<AppData>(context, listen: false)
          .updatePickUpAdress(userPickUpAdress);
    }
    return placeAddress;
  }
}
