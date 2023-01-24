import 'package:flutter/material.dart';
import 'package:instagram_completion/screens/add_post_screen.dart';
import 'package:instagram_completion/screens/feed_screen.dart';
import 'package:instagram_completion/screens/search_screen.dart';

const webScreenSize = 600;

final homeScreenItems = [
  const FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const Text('feed'),
  const Text('feed'),
];
