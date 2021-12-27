import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:task/models/banner.dart';
import 'package:task/repository/rest_api_repo.dart';
import 'package:task/widgets/display_iimage.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  void _launchURL(BuildContext context, {String? url}) async {
    if (url != null && url != '') {
      if (!await launch(url)) throw 'Could not launch $url';
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Invalid url')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final _restApiRepo = context.read<RestApiRepo>();
    final _canvas = MediaQuery.of(context).size;
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     print('List data ${await _restApiRepo.getBanners()}');
      //   },
      // ),
      body: Center(
        child: FutureBuilder<List<HomeBanner?>>(
          future: _restApiRepo.getBanners(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            final data = snapshot.data;
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data?.length,
              itemBuilder: (context, index) {
                final banner = data?[index];

                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: _canvas.width * 0.95,
                        height: 200.0,
                        child: DisplayImage(
                          imageUrl: banner?.image,
                          // width: 300.0,
                        ),
                      ),
                      // Image.network(
                      //   banner?.image ?? errorImage,
                      //   fit: BoxFit.cover,
                      // ),
                      const SizedBox(height: 15.0),
                      TextButton(
                        onPressed: () async {
                          _launchURL(context, url: banner!.url);
                        },
                        child: const Text('View'),
                      )
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
