class AppConstants {
  // App Info
  static const String appName = 'BiliBenta';
  static const String tagline = 'Buy Smart, Sell Fast';
  static const String version = '1.0.0';

  // Supabase Tables
  static const String usersTable = 'users';
  static const String profilesTable = 'profiles';
  static const String categoriesTable = 'categories';
  static const String listingsTable = 'listings';
  static const String listingImagesTable = 'listing_images';
  static const String favoritesTable = 'favorites';
  static const String conversationsTable = 'conversations';
  static const String messagesTable = 'messages';
  static const String offersTable = 'offers';
  static const String transactionsTable = 'transactions';
  static const String reviewsTable = 'reviews';
  static const String reportsTable = 'reports';
  static const String blocksTable = 'blocks';
  static const String notificationsTable = 'notifications';
  static const String verificationTable = 'user_verifications';
  static const String auditLogsTable = 'audit_logs';

  // Supabase Storage Buckets
  static const String profileImagesBucket = 'profile_images';
  static const String listingImagesBucket = 'listing_images';
  static const String verificationDocsBucket = 'verification_docs';

  // Listing Conditions
  static const String conditionNew = 'new';
  static const String conditionLikeNew = 'like_new';
  static const String conditionUsed = 'used';

  // Listing Status
  static const String statusDraft = 'draft';
  static const String statusActive = 'active';
  static const String statusReserved = 'reserved';
  static const String statusSold = 'sold';
  static const String statusRemoved = 'removed';
  static const String statusRejected = 'rejected';
  static const String statusExpired = 'expired';

  // Offer Status
  static const String offerPending = 'pending';
  static const String offerAccepted = 'accepted';
  static const String offerDeclined = 'declined';
  static const String offerCountered = 'countered';
  static const String offerCancelled = 'cancelled';
  static const String offerExpired = 'expired';

  // Transaction Status
  static const String transactionPending = 'pending';
  static const String transactionMeetupScheduled = 'meetup_scheduled';
  static const String transactionCompleted = 'completed';
  static const String transactionCancelled = 'cancelled';

  // Report Reasons
  static const List<String> reportReasons = [
    'fraud_scam',
    'prohibited_item',
    'fake_listing',
    'harassment',
    'counterfeit_product',
    'suspicious_account',
    'other',
  ];

  // Max Image Upload
  static const int maxImagesPerListing = 8;
  static const int maxImageSizeInMB = 5;

  // Validation Rules
  static const int minPasswordLength = 8;
  static const int minPhoneLength = 10;
  static const int maxBioLength = 500;

  // Categories
  static const List<String> mainCategories = [
    'Fashion',
    'Electronics',
    'Vehicles',
    'Home & Furniture',
    'Properties',
    'Services',
    'Others',
  ];

  // Filipino Provinces (Sample)
  static const List<String> provinces = [
    'Abra',
    'Agusan del Norte',
    'Agusan del Sur',
    'Aklan',
    'Albay',
    'Antique',
    'Apayao',
    'Aurora',
    'Basilan',
    'Bataan',
    'Batangas',
    'Batanes',
    'Benguet',
    'Biliran',
    'Bohol',
    'Bukidnon',
    'Bulacan',
    'Calamianes',
    'Camarines Norte',
    'Camarines Sur',
    'Camiguin',
    'Capiz',
    'Catanduanes',
    'Cavite',
    'Cebu',
    'Cotabato',
    'Davao del Norte',
    'Davao del Sur',
    'Davao Occidental',
    'Davao Oriental',
    'Dinagat Islands',
    'Eastern Samar',
    'Guimaras',
    'Ifugao',
    'Ilocos Norte',
    'Ilocos Sur',
    'Iloilo',
    'Isabela',
    'Kalinga',
    'Laguna',
    'Lanao del Norte',
    'Lanao del Sur',
    'La Union',
    'Leyte',
    'Maguindanao',
    'Marinduque',
    'Masbate',
    'Metro Manila',
    'Misamis Oriental',
    'Misamis Occidental',
    'Mountain Province',
    'Negros Occidental',
    'Negros Oriental',
    'Northern Samar',
    'Nueva Ecija',
    'Nueva Vizcaya',
    'Palawan',
    'Pampanga',
    'Pangasinan',
    'Quezon',
    'Quirino',
    'Rizal',
    'Romblon',
    'Samar',
    'Sarangani',
    'Siquijor',
    'Sorsogon',
    'South Cotabato',
    'Southern Leyte',
    'Sultan Kudarat',
    'Sulu',
    'Surigao del Norte',
    'Surigao del Sur',
    'Tarlac',
    'Tawi-Tawi',
    'Zambales',
    'Zamboanga del Norte',
    'Zamboanga del Sur',
    'Zamboanga Sibugay',
  ];

  // PHP Currency
  static const String currencySymbol = '₱';

  // Date Formats
  static const String dateFormat = 'MMM d, yyyy';
  static const String timeFormat = 'h:mm a';
}