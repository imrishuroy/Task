import 'package:task/models/banner.dart';

abstract class BaseRestApiRepo {
  Future<List<HomeBanner?>> getBanners();
}
