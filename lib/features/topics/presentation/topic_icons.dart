import 'package:flutter/material.dart';

IconData topicIcon(String key) {
  return switch (key) {
    'home' => Icons.home_outlined,
    'family' => Icons.family_restroom_outlined,
    'people' => Icons.groups_outlined,
    'food' => Icons.restaurant_menu_outlined,
    'restaurant' => Icons.restaurant_outlined,
    'cart' => Icons.shopping_cart_outlined,
    'shirt' => Icons.checkroom_outlined,
    'sports' => Icons.sports_soccer_outlined,
    'movie' => Icons.movie_outlined,
    'book' => Icons.menu_book_outlined,
    'flight' => Icons.flight_outlined,
    'hotel' => Icons.hotel_outlined,
    'bus' => Icons.directions_bus_outlined,
    'map' => Icons.map_outlined,
    'school' => Icons.school_outlined,
    'work' => Icons.work_outline_rounded,
    'devices' => Icons.devices_outlined,
    'wifi' => Icons.wifi_rounded,
    'code' => Icons.code_rounded,
    'shield' => Icons.shield_outlined,
    'ai' => Icons.psychology_outlined,
    'health' => Icons.health_and_safety_outlined,
    'hospital' => Icons.local_hospital_outlined,
    'warning' => Icons.warning_amber_rounded,
    'money' => Icons.account_balance_wallet_outlined,
    'chart' => Icons.show_chart_rounded,
    'news' => Icons.newspaper_outlined,
    'culture' => Icons.theater_comedy_outlined,
    'law' => Icons.gavel_outlined,
    'gov' => Icons.account_balance_outlined,
    'vote' => Icons.how_to_vote_outlined,
    'flag' => Icons.flag_outlined,
    'war' => Icons.public_outlined,
    'eco' => Icons.park_outlined,
    'science' => Icons.science_outlined,
    _ => Icons.folder_outlined,
  };
}

String localizedPair(BuildContext context, String en, String ar) {
  final code = Localizations.localeOf(context).languageCode;
  return code == 'ar' ? ar : en;
}
