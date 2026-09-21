import 'package:flutter/material.dart';
import '../features/splash/splash_screen.dart';
import '../features/onboarding/onboarding_screen.dart';
import '../features/auth/login_screen.dart';
import '../features/auth/register_screen.dart';
import '../features/auth/otp_screen.dart';
import '../features/auth/forgot_password_screen.dart';
import '../features/home/home_screen.dart';
import '../features/search/search_screen.dart';
import '../features/listings/listing_detail_screen.dart';
import '../features/listings/seller_profile_screen.dart';
import '../features/selling/sell_photos_screen.dart';
import '../features/selling/sell_form_screen.dart';
import '../features/selling/sell_preview_screen.dart';
import '../features/selling/my_listings_screen.dart';
import '../features/chat/chat_list_screen.dart';
import '../features/chat/conversation_screen.dart';
import '../features/favorites/favorites_screen.dart';
import '../features/profile/profile_screen.dart';
import '../features/reviews/reviews_screen.dart';
import '../features/safety/safety_center_screen.dart';
import '../features/settings/settings_screen.dart';

class AppRouter {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String otp = '/otp';
  static const String forgotPassword = '/forgot-password';
  static const String home = '/home';
  static const String search = '/search';
  static const String listingDetail = '/listing-detail';
  static const String sellerProfile = '/seller-profile';
  static const String sellPhotos = '/sell-photos';
  static const String sellForm = '/sell-form';
  static const String sellPreview = '/sell-preview';
  static const String myListings = '/my-listings';
  static const String chatList = '/chat-list';
  static const String conversation = '/conversation';
  static const String favorites = '/favorites';
  static const String profile = '/profile';
  static const String reviews = '/reviews';
  static const String safety = '/safety';
  static const String settings = '/settings';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case otp:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => OtpScreen(
            phone: args?['phone'] ?? '',
            isLogin: args?['isLogin'] ?? true,
          ),
        );
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case search:
        return MaterialPageRoute(builder: (_) => const SearchScreen());
      case listingDetail:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => ListingDetailScreen(listingId: args?['listingId'] ?? ''),
        );
      case sellerProfile:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => SellerProfileScreen(sellerId: args?['sellerId'] ?? ''),
        );
      case sellPhotos:
        return MaterialPageRoute(builder: (_) => const SellPhotosScreen());
      case sellForm:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => SellFormScreen(images: args?['images'] ?? []),
        );
      case sellPreview:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => SellPreviewScreen(listing: args?['listing']),
        );
      case myListings:
        return MaterialPageRoute(builder: (_) => const MyListingsScreen());
      case chatList:
        return MaterialPageRoute(builder: (_) => const ChatListScreen());
      case conversation:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => ConversationScreen(
            conversationId: args?['conversationId'] ?? '',
            otherUserId: args?['otherUserId'] ?? '',
            listingId: args?['listingId'],
          ),
        );
      case favorites:
        return MaterialPageRoute(builder: (_) => const FavoritesScreen());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case reviews:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => ReviewsScreen(transactionId: args?['transactionId'] ?? ''),
        );
      case safety:
        return MaterialPageRoute(builder: (_) => const SafetyCenterScreen());
      case settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}