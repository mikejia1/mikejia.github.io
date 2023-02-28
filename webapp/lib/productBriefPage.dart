import 'package:flutter/material.dart';

// Page for displaying product brief
class ProductBriefPage extends StatelessWidget {
  //A list containing 10 new GlobalKey objects.
  final List<GlobalKey> sectionKeys = List.generate(10, (i) => GlobalKey());

  ProductBriefPage({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scroll To Index Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Row(children: <Widget>[
          const Text("hola"),
          Column(children: _buildSectionTiles()),
          CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate([
                  Column(
                    children: const [
                      Text("yoyo"),
                      Text("eat tofu"),
                    ],
                  ),
                ]),
              ),
            ],
          ),
          _buildMainContent(context),
        ]),
      ),
    );
  }

  Column _buildSectionNavigator() {
    return Column(
        children: [Text("yo soy el navigator"), ..._buildSectionTiles()]);
  }

  CustomScrollView _buildMainContent(BuildContext context) {
    return CustomScrollView(
      scrollDirection: Axis.vertical,
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate([
            Column(children: _buildSections()),
          ]),
        ),
      ],
    );
  }

  List<Container> _buildSections() => List.generate(
      10,
      (i) => Container(
          key: sectionKeys[i],
          child: SizedBox(height: 400, child: Text('PB $i.jpg'))));

  List<TextButton> _buildSectionTiles() => List.generate(
      10,
      (i) => TextButton(
          onPressed: () => {},
          // Scrollable.ensureVisible(sectionKeys[i].currentContext!),
          child: Text('Section $i')));
}
