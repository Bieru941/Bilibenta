import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/listing_model.dart';
import '../core/constants/app_constants.dart';
import 'supabase_service.dart';

class ListingService {
  static final _supabase = SupabaseService.client;

  static Future<String> createListing(ListingModel listing) async {
    try {
      final response = await _supabase
          .from(AppConstants.listingsTable)
          .insert(listing.toJson())
          .select('id')
          .single();
      
      return response['id'];
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> updateListing(ListingModel listing) async {
    try {
      await _supabase
          .from(AppConstants.listingsTable)
          .update(listing.toJson())
          .eq('id', listing.id);
    } catch (e) {
      rethrow;
    }
  }

  static Future<ListingModel?> getListingById(String listingId) async {
    try {
      // Increment views
      final current = await _supabase
          .from(AppConstants.listingsTable)
          .select('views')
          .eq('id', listingId)
          .single();
      
      await _supabase
          .from(AppConstants.listingsTable)
          .update({'views': (current['views'] ?? 0) + 1})
          .eq('id', listingId);
      
      final response = await _supabase
          .from(AppConstants.listingsTable)
          .select()
          .eq('id', listingId)
          .single();
      
      return ListingModel.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  static Future<List<ListingModel>> getNearbyListings({
    String? province,
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      var query = _supabase
          .from(AppConstants.listingsTable)
          .select()
          .eq('status', AppConstants.statusActive)
          .order('created_at', ascending: false)
          .range(offset, offset + limit - 1);
      
      if (province != null) {
        query = query.eq('province', province);
      }
      
      final response = await query;
      
      return (response as List)
          .map((listing) => ListingModel.fromJson(listing))
          .toList();
    } catch (e) {
      return [];
    }
  }

  static Future<List<ListingModel>> searchListings({
    String? query,
    String? category,
    double? minPrice,
    double? maxPrice,
    String? location,
    String? condition,
    bool? isVerified,
    bool? isNegotiable,
    String? sortBy = 'newest',
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      var request = _supabase
          .from(AppConstants.listingsTable)
          .select()
          .eq('status', AppConstants.statusActive);
      
      if (query != null && query.isNotEmpty) {
        request = request.or('title.ilike.%$query%,description.ilike.%$query%');
      }
      
      if (category != null) {
        request = request.eq('category_id', category);
      }
      
      if (minPrice != null) {
        request = request.gte('price', minPrice);
      }
      
      if (maxPrice != null) {
        request = request.lte('price', maxPrice);
      }
      
      if (location != null) {
        request = request.eq('province', location);
      }
      
      if (condition != null) {
        request = request.eq('condition', condition);
      }
      
      if (isNegotiable != null) {
        request = request.eq('is_negotiable', isNegotiable);
      }
      
      // Handle sorting
      switch (sortBy) {
        case 'price_low_to_high':
          request = request.order('price', ascending: true);
          break;
        case 'price_high_to_low':
          request = request.order('price', ascending: false);
          break;
        case 'nearest':
          // Implement location-based sorting
          request = request.order('province', ascending: true);
          break;
        case 'relevant':
          request = request.order('views', ascending: false);
          break;
        default:
          request = request.order('created_at', ascending: false);
      }
      
      final response = await request.range(offset, offset + limit - 1);
      
      return (response as List)
          .map((listing) => ListingModel.fromJson(listing))
          .toList();
    } catch (e) {
      return [];
    }
  }

  static Future<List<ListingModel>> getSellerListings(String sellerId) async {
    try {
      final response = await _supabase
          .from(AppConstants.listingsTable)
          .select()
          .eq('seller_id', sellerId)
          .order('created_at', ascending: false);
      
      return (response as List)
          .map((listing) => ListingModel.fromJson(listing))
          .toList();
    } catch (e) {
      return [];
    }
  }

  static Future<void> deleteListing(String listingId) async {
    try {
      await _supabase
          .from(AppConstants.listingsTable)
          .delete()
          .eq('id', listingId);
    } catch (e) {
      rethrow;
    }
  }

  static Future<String> uploadListingImage(String listingId, String imagePath) async {
    try {
      final fileName = '${listingId}_${DateTime.now().millisecondsSinceEpoch}.jpg';
      
      await _supabase.storage
          .from(AppConstants.listingImagesBucket)
          .upload(fileName, File(imagePath));
      
      final publicUrl = _supabase.storage
          .from(AppConstants.listingImagesBucket)
          .getPublicUrl(fileName);
      
      return publicUrl;
    } catch (e) {
      rethrow;
    }
  }
}