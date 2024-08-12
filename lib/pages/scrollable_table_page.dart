import 'package:flutter/material.dart';

class ScrollableTablePage extends StatelessWidget {
  const ScrollableTablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scrollable Table Example'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Table(
          border: TableBorder.all(),
          children: [
            const TableRow(children: [
              TableCell(
                  child: Padding(
                      padding: EdgeInsets.all(8.0), child: Text('Header 1'))),
              TableCell(
                  child: Padding(
                      padding: EdgeInsets.all(8.0), child: Text('Header 2'))),
              TableCell(
                  child: Padding(
                      padding: EdgeInsets.all(8.0), child: Text('Header 3'))),
              TableCell(
                  child: Padding(
                      padding: EdgeInsets.all(8.0), child: Text('Header 4'))),
              TableCell(
                  child: Padding(
                      padding: EdgeInsets.all(8.0), child: Text('Header 5'))),
              TableCell(
                  child: Padding(
                      padding: EdgeInsets.all(8.0), child: Text('Header 6'))),
              TableCell(
                  child: Padding(
                      padding: EdgeInsets.all(8.0), child: Text('Header 7'))),
            ]),
            for (int i = 0; i < 20; i++)
              TableRow(children: [
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Cell $i-1'),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Cell $i-2'),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Cell $i-3'),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Cell $i-4'),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Cell $i-5'),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Cell $i-6'),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Cell $i-7'),
                  ),
                ),
              ]),
          ],
        ),
      ),
    );
  }
}
