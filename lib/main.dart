import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:urban_style_delivery/pages/splash/splash.dart';

import 'controllers/engine/engine_controller.dart';



void main() async{
  EasyLoading.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final keyApplicationId = '8fFAky14KWuFrjlKontoTQ4P8mKKNbRz2IIsOXkb';
  final keyClientKey = 'ms2So5j1rzucZ6ojWlYrKLMxzg6whB5Wx35lV7w3';
  final keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, autoSendSessionId: true);
  print('done');

  runApp(const engine());
}



class engine extends StatefulWidget {
  const engine({Key? key}) : super(key: key);

  @override
  State<engine> createState() => _engineState();
}

class _engineState extends State<engine> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    engine_controller.update_status();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      engine_controller.update_status();
    }
  }


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,

      ),
      home: splash(),
    );
  }
}