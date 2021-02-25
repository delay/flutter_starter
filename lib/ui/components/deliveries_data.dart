/// Flutter code sample for DataTable

// This sample shows how to display a [DataTable] with three columns: name, age, and
// role. The columns are defined by three [DataColumn] objects. The table
// contains three rows of data for three example users, the data for which
// is defined by three [DataRow] objects.
//
// ![](https://flutter.github.io/assets-for-api-docs/assets/material/data_table.png)

import 'package:flutter/material.dart';

/// This is the main application widget.
class DeliveriesData extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: MyStatelessWidget(),
      ),
    );
  }
}

/// This is the stateless widget that the main application instantiates.
class MyStatelessWidget extends StatelessWidget {
  MyStatelessWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Text(
            'Stop',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Location',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Payment',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
      ],
      rows: const <DataRow>[
        DataRow(
          cells: <DataCell>[
            DataCell(Text('4')),
            DataCell(Text('Health Rx Pharamacy')),
            DataCell(Text('\$19')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('6')),
            DataCell(Text('Wellness Pharmacy')),
            DataCell(Text('\$43')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('5')),
            DataCell(Text('Green Pharmacy')),
            DataCell(Text('\$27')),
          ],
        ),
      ],
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  static const int numItems = 10;
  List<bool> selected = List<bool>.generate(numItems, (index) => false);

  @override
  Widget build(BuildContext context) {
    List<DataRow> dataRows = List<DataRow>.generate(
      numItems,
      (index) => DataRow(
        color: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          // All rows will have the same selected color.
          // if (states.contains(MaterialState.selected))
          //   return Theme.of(context).colorScheme.primary.withOpacity(0.08);
          // Even rows will have a grey color.
          if (index % 2 == 0) return Colors.grey.withOpacity(0.3);
          return null; // Use default value for other states and odd rows.
        }),
        cells: [DataCell(Text('Row $index')), DataCell(Text('Row $index'))],
        selected: selected[index],
        onSelectChanged: (bool value) {
          print("good $index");
          // setState(() {
          //   selected[index] = value;
          // });
        },
      ),
    );

    List<DataRow> dataRows2 = [
      DataRow(cells: [
        DataCell(Text("3")),
        DataCell(Text("Green Pharmacy")),
        DataCell(Text("\$9"))
      ]),
      DataRow(cells: [
        DataCell(Text("5")),
        DataCell(Text("Wellness Pharmacy")),
        DataCell(Text("\$12"))
      ]),
      DataRow(cells: [
        DataCell(Text("2")),
        DataCell(Text("Health Rx Pharamacy")),
        DataCell(Text("\$4"))
      ])
    ];

    return SizedBox(
      width: double.infinity,
      child: DataTable(
          showCheckboxColumn: false,
          columns: const <DataColumn>[
            DataColumn(
              label: Text('Stops'),
            ),
            DataColumn(
              label: Text('Location'),
            ),
            DataColumn(
              label: Text('Payment'),
            ),
          ],
          rows: dataRows2),
    );
  }
}
