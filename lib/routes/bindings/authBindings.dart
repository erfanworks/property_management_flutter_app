import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import '../../screens/BaseScreen/NavBar/controller/navbar_controller.dart';
import '../../screens/UserScreen/LandlordAllScreen/HomeTabAllScreen/HomeScreen/controller/home_controller.dart';

class AuthBindings extends Bindings {
  @override
  void dependencies() {
    //=========NavBar=========//
    Get.lazyPut(() => NavbarController(), fenix: true);
    Get.lazyPut(() => HomeController());

  }
}
