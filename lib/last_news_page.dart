import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rss/provider/provider_last.dart';
import 'package:rss/provider/provider_last24.dart';

import '../../utils/utils.dart';
import '../../widgets/image_news_widget.dart';
import 'utils/rss.dart';

class LastNewsPage extends StatelessWidget {
  const LastNewsPage({Key? key, required Api newsProvider})
      : _newsProvider = newsProvider,
        super(key: key);
  final Api _newsProvider;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (BuildContext context) => Last_Provider(),
        builder: (context, child) => page2(context));
  }

  Widget page2(BuildContext context) {
    final provider2 = context.read<Last_Provider>();
    final providerWatch2 = context.watch<Last_Provider>();

    if (providerWatch2.isLoad == false) {
      providerWatch2.loadNews();

      return const Center(child: CircularProgressIndicator());
    }

    if (providerWatch2.error == true) {
      return const Text("Error", style: TextStyle(fontSize: 24));
    }

    if (providerWatch2.isLoad == true) {
      return RefreshIndicator(
        child: listBuilder(context, providerWatch2),
        onRefresh: () => provider2.reloadNews(),
      );
    } else {
      return Container();
    }
  }

  Widget listBuilder(BuildContext context, providerWatch2) {
    return ListView.builder(
        itemCount: providerWatch2.news2.length,
        itemBuilder: (BuildContext context, int index) {
          final item = providerWatch2.news2[index];
          return ListTile(
            title: Text(
              item.title!,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              maxLines: 8,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right,
              color: Colors.grey[300]!,
              size: 30,
            ),
            contentPadding: const EdgeInsets.all(15),
            onTap: () => launchUniversalLink(item.link!),
            leading: ImageNewsWidget(
              urlImage: item.enclosure!.url!,
            ),
          );
        });
  }
}
