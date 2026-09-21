import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'core/theme/app_theme.dart';
import 'core/routing/app_router.dart';
import 'services/supabase_service.dart';
import 'services/auth_service.dart';
import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize Supabase
  await Supabase.initialize(
    url: 'https://YOUR_PROJECT.supabase.co',
    anonKey: 'YOUR_ANON_KEY',
  );

  // Initialize notifications
  await NotificationService.initialize();

  runApp(const BiliBentaApp());
}

class BiliBentaApp extends StatefulWidget {
  const BiliBentaApp({Key? key}) : super(key: key);

  @override
  State<BiliBentaApp> createState() => _BiliBentaAppState();
}

class _BiliBentaAppState extends State<BiliBentaApp> {
  late AuthService _authService;
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _authService = AuthService();
    _loadThemePreference();
  }

  void _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => _authService),
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(_isDarkMode),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            title: 'BiliBenta - Buy Smart, Sell Fast',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: const SplashScreen(),
            onGenerateRoute: AppRouter.generateRoute,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  ThemeProvider(this._isDarkMode);

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _isDarkMode);
    notifyListeners();
  }
}