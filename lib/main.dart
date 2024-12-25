import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:locket/configs/provider_setup.dart';
import 'package:locket/screens/login_screen.dart';
import 'package:locket/layouts/mobile_screen_layout.dart';
import 'package:locket/layouts/responsive_layout.dart';
import 'package:locket/layouts/web_screen_layout.dart';
import 'package:locket/utils/colors.dart';
import 'package:provider/provider.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  try {
    await dotenv.load(fileName: ".env"); // Load environment variables
    if (kDebugMode) {
      print('Loaded .env file');
      print('USE_EMULATOR: ${dotenv.env['USE_EMULATOR']}');
    }
  } catch (e) {
    throw Exception('Error loading .env file: $e'); // Print error if any
  }

  // initialise app based on platform- web or mobile
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCruOqr6Bs9YT_JqqrFFr56TUJTiXezRGg",
          appId: "1:261946660163:web:c8e32e5f1fd826d7408bf6",
          messagingSenderId: "261946660163",
          projectId: "nodejs-demo-5f3ba",
          storageBucket: 'nodejs-demo-5f3ba.appspot.com'
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:  providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Auction Koi',
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        routes: {
          '/login': (context) => const LoginScreen(),
        },
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              // Checking if the snapshot has any data or not
              if (snapshot.hasData) {
                // if snapshot has data which means user is logged in then we check the width of screen and accordingly display the screen layout
                return const ResponsiveLayout(
                  mobileScreenLayout: MobileScreenLayout(),
                  webScreenLayout: WebScreenLayout(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }

            // means connection to future hasnt been made yet
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return const LoginScreen();//starting screen
          },
        ),
      ),
    );
  }
}