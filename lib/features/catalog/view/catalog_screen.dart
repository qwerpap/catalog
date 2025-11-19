import 'package:catalog/features/global/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(52),
        child: CustomAppBar(title: 'Catalog'),
      ),
      body: ListView(children: [Text('data')]),
    );
  }
}
