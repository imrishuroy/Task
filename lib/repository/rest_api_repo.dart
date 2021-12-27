import 'package:dio/dio.dart';
import 'package:task/constants/contants.dart';
import 'package:task/models/banner.dart';
import 'package:task/repository/base_rest_api_repo.dart';

class RestApiRepo extends BaseRestApiRepo {
  final _dio = Dio();

  @override
  Future<List<HomeBanner?>> getBanners() async {
    List<HomeBanner?> banners = [];
    try {
      final response = await _dio.get(apiUrl);
      if (response.statusCode == 200) {
        //   print('Response data ${response.data}');
        print('Response data type ${response.data.runtimeType}');

        final List homeData = response.data['home_banner'] ?? [];
        //print('Home Banner data ${homeData.runtimeType}');

        for (var element in homeData) {
          print('Element $element');
          banners.add(HomeBanner.fromMap(element));
        }
      }

      return banners;
    } catch (error) {
      print('Error getting banners ${error.toString()}');
      rethrow;
    }
  }
}
