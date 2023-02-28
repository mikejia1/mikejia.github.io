import 'package:flutter/material.dart';
import 'package:webapp/corpus.dart';

// Base card consists of a Card and an overlayed status icon.
class BaseCard extends StatelessWidget {
  const BaseCard({super.key});
  @override
  Widget build(BuildContext context) {
    return const Card();
  }
}

class TitleCard extends StatelessWidget {
  final String title;
  final String status;

  const TitleCard({Key? key, required this.title, required this.status})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => StatusCard(
                  title: title, sectionStatusMap: const <String, String>{}));
        },
        child: Card(
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Text(title),
          Text(status),
        ])));
  }
}

class StatusCard extends StatelessWidget {
  final String title;
  final Map<String, String> sectionStatusMap;

  const StatusCard(
      {Key? key, required this.title, required this.sectionStatusMap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    //A dialog that has a gridview of cards.
    return AlertDialog(
        title: const Text('Status'),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.height * 0.3,
          child: const SectionGrid(),
        ));
  }
}

class SectionGrid extends StatelessWidget {
  const SectionGrid({super.key});
  @override
  Widget build(BuildContext context) {
    return _buildGrid(context);
  }
}

Widget _buildGrid(BuildContext context) => GridView.extent(
      maxCrossAxisExtent: 150,
      padding: const EdgeInsets.all(4),
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      children: _buildSectionCards(context),
    );
//;

List<Container> _buildSectionCards(BuildContext context) => List.generate(
    10,
    (i) => Container(
        child: Card(
            child: TextButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ArticlePage(sections: sections))),
                child: Text('Section $i.jpg')))));
