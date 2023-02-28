import 'package:flutter/material.dart';

class Section {
  final GlobalKey key;
  final String title;
  final String body;

  const Section(this.key, this.title, this.body);
}

const reallyLongBody =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce venenatis pharetra dui, ac semper nulla dapibus ultrices.'
    ' Pellentesque sed erat accumsan lorem rhoncus mattis eu eget nulla. Phasellus sagittis vehicula dapibus. Nulla dolor nunc, '
    'feugiat ac ullamcorper vel, commodo sed lacus. Nunc volutpat rutrum euismod. Nullam venenatis imperdiet odio, non porta leo '
    'ullamcorper ac. Aliquam fringilla mauris ut ante faucibus, non tempus elit placerat. Donec sed porttitor tellus. Donec lobortis '
    'arcu id lectus commodo varius. Fusce tincidunt ante in faucibus suscipit. Nulla facilisi. Nunc at nibh dictum sem aliquet '
    'consectetur eu nec neque. Nullam ullamcorper vulputate nisl quis pharetra. Etiam dapibus ullamcorper magna, a iaculis libero '
    'dignissim in. Vestibulum dictum, justo posuere consectetur eleifend, augue mi dictum dui, eu sollicitudin elit mauris vel lacus. '
    'Donec dui felis, dapibus vel urna at, commodo facilisis felis.\nCurabitur faucibus leo ipsum, in vehicula risus rhoncus id. Donec '
    'ac velit quis nulla suscipit efficitur. Nulla non euismod neque. Sed blandit urna sed ex tempor sagittis. Curabitur condimentum nec '
    'dui quis sollicitudin. Proin consectetur, metus sed rutrum varius, mi augue placerat est, sed posuere risus nunc ac urna. Nam leo '
    'erat, bibendum non nibh sed, sollicitudin aliquet metus. Aliquam finibus turpis vitae leo laoreet molestie.';

final sections = [
  Section(GlobalKey(), '1. Section', reallyLongBody),
  Section(GlobalKey(), '2. Section', reallyLongBody),
  Section(GlobalKey(), '3. Section', reallyLongBody),
  Section(GlobalKey(), '4. Section', reallyLongBody),
  Section(GlobalKey(), '5. Section', reallyLongBody),
  Section(GlobalKey(), '6. Section', reallyLongBody),
];

class SectionWidget extends StatelessWidget {
  final Section section;

  const SectionWidget({Key? key, required this.section}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: Color(0xfffff8e2),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              section.title,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline2
                  ?.copyWith(color: Colors.black),
            ),
            const SizedBox(
              height: 36,
            ),
            Text(
              section.body,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(color: Colors.black54, height: 1.3),
            )
          ],
        ));
  }
}

class SectionLink extends StatelessWidget {
  final Section section;
  final void Function(Section) onTap;

  const SectionLink({Key? key, required this.section, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(section),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          section.title,
          style: Theme.of(context)
              .textTheme
              .headline3
              ?.copyWith(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class TableOfContents extends StatelessWidget {
  final List<Section> sections;
  final void Function(Section) onItemTap;

  const TableOfContents({
    Key? key,
    this.sections = const <Section>[],
    required this.onItemTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.only(left: 16, top: 24, right: 16, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white12.withOpacity(0.3),
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        border: Border.all(
          width: 2,
          color: Colors.grey,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: sections
            .map((e) => SectionLink(section: e, onTap: onItemTap))
            .toList(),
      ),
    );
  }
}

class ArticlePage extends StatelessWidget {
  final List<Section> sections;
  const ArticlePage({Key? key, required this.sections}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tableOfContents = TableOfContents(
      sections: sections,
      onItemTap: (section) {
        final targetContext = section.key.currentContext;
        if (targetContext != null) {
          Scrollable.ensureVisible(
            targetContext,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
        }
      },
    );

    final listView = ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: sections.length,
      itemBuilder: (BuildContext context, int index) {
        final section = sections[index];

        return SectionWidget(
          key: section.key,
          section: section,
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                tableOfContents,
                listView,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
