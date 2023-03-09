import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CustomCacheManager extends CacheManager {
  CustomCacheManager() : super(
    Config(
      "JUMBLE_CACHE",
      stalePeriod: const Duration(days: 1),
      maxNrOfCacheObjects: 10000,
    ),
  );
}