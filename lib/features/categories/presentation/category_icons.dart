import 'package:flutter/material.dart';

IconData categoryIcon(String name) {
  return switch (name) {
    'home' => Icons.home_outlined,
    'work' => Icons.work_outline_rounded,
    'school' => Icons.school_outlined,
    'flight' => Icons.flight_outlined,
    'favorite' => Icons.favorite_outline_rounded,
    'restaurant' => Icons.restaurant_outlined,
    'health' => Icons.health_and_safety_outlined,
    'devices' => Icons.devices_outlined,
    'book' => Icons.menu_book_outlined,
    'chat' => Icons.chat_bubble_outline_rounded,
    'star' => Icons.star_outline_rounded,
    'folder' || _ => Icons.folder_outlined,
  };
}

const kCategoryIconChoices = <String>[
  'folder',
  'home',
  'work',
  'school',
  'flight',
  'favorite',
  'restaurant',
  'health',
  'devices',
  'book',
  'chat',
  'star',
];
