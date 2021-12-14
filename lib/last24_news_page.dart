import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/provider_last24.dart';
import 'utils/rss.dart';
import 'widgets/list_item_widget.dart';

class Last24NewsPage extends StatelessWidget {
  const Last24NewsPage({Key? key, required Api newsProvider})
      : _newsProvider = newsProvider,
        super(key: key);
  final Api _newsProvider;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (BuildContext context) => Last24_Provider(),
        builder: (context, child) => page(context));
  }

  Widget page(BuildContext context) {
    final provider = context.read<Last24_Provider>();
    final providerWatch = context.watch<Last24_Provider>();

    if (providerWatch.isLoad == false) {
      providerWatch.loadNews();

      return const Center(child: CircularProgressIndicator());
    }

    if (providerWatch.error == true) {
      return const Text("Error", style: TextStyle(fontSize: 24));
    }

    if (providerWatch.isLoad == true) {
      return RefreshIndicator(
        child: listBuilder(context, providerWatch),
        onRefresh: () => provider.reloadNews(),
      );
    } else {
      return Container();
    }
  }

  Widget listBuilder(BuildContext context, providerWatch) {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          final item = providerWatch.news[index];
          return ListItemWidget(item: item);
        });
  }
}
