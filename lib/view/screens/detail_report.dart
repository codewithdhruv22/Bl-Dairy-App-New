import 'package:bl_dairy_app/constants/Theme.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class DetailReportScreen extends StatefulWidget {
  const DetailReportScreen({Key? key}) : super(key: key);

  @override
  State<DetailReportScreen> createState() => _DetailReportScreenState();
}

double totalAmnt = 0.0;
double fatRate = 0.0;
List<Employee> employees = <Employee>[];
late EmployeeDataSource employeeDataSource;

class _DetailReportScreenState extends State<DetailReportScreen> {
  @override
  void initState() {
    employees = getEmployeeData();
    employeeDataSource = EmployeeDataSource(employeeData: employees);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Detailed View'),
          backgroundColor: MyColors.primary,
          elevation: 0,
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Week',
              ),
              Tab(
                text: 'Month',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            matter(data: weekdata),
            matter(data: monthdata),
          ],
        ),
      ),
    );
  }

  Widget matter({
    required List<_SalesData> data,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SfCartesianChart(
            enableMultiSelection: false,
            enableSideBySideSeriesPlacement: false,
            backgroundColor: MyColors.primary,
            plotAreaBorderColor: Colors.transparent,
            primaryYAxis: NumericAxis(
                isVisible: false,
                majorGridLines: const MajorGridLines(width: 0)),
            primaryXAxis: CategoryAxis(
                majorGridLines: const MajorGridLines(width: 0),
                labelStyle: const TextStyle(color: MyColors.white)),
            // Chart title

            // Enable tooltip
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <ChartSeries<_SalesData, String>>[
              ColumnSeries<_SalesData, String>(
                  color: const Color.fromARGB(197, 252, 252, 252),
                  trackBorderWidth: 0,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                  dataSource: data,
                  xValueMapper: (_SalesData sales, _) => sales.day,
                  yValueMapper: (_SalesData sales, _) => sales.sales,
                  name: 'Sales',
                  // Enable data label
                  dataLabelSettings: const DataLabelSettings(isVisible: true))
            ]),
        SfDataGrid(
          selectionMode: SelectionMode.single,
          onCellTap: (details) {},
          onSelectionChanged: (addedRows, removedRows) {
            print(addedRows.length);
            print(removedRows);
          },
          source: employeeDataSource,
          columnWidthMode: ColumnWidthMode.fill,
          columns: <GridColumn>[
            GridColumn(
                columnName: 'Date',
                label: Container(
                    padding: const EdgeInsets.all(16.0),
                    alignment: Alignment.center,
                    child: const Text(
                      'Date',
                    ))),
            GridColumn(
                columnName: 'name',
                label: Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: const Text('Name'))),
            GridColumn(
                columnName: 'Shift',
                label: Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: const Text(
                      'Shift',
                      overflow: TextOverflow.ellipsis,
                    ))),
            GridColumn(
                columnName: 'Quantity',
                label: Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: const Text('Quantity'))),
          ],
        ),
      ],
    );
  }
}

List<_SalesData> weekdata = [
  _SalesData('Sun', 3500),
  _SalesData('Mon', 2800),
  _SalesData('Tues', 3400),
  _SalesData('Wed', 3200),
  _SalesData('Thu', 4000),
  _SalesData('Fri', 4000),
  _SalesData('Sat', 80),
];
List<_SalesData> monthdata = [
  _SalesData('01', 35),
  _SalesData('02', 28),
  _SalesData('03', 34),
  _SalesData('04', 32),
  _SalesData('05', 40),
  _SalesData('06', 40),
  _SalesData('07', 80),
  _SalesData('08', 80),
  _SalesData('09', 80),
  _SalesData('10', 80),
  _SalesData('11', 35),
  _SalesData('12', 28),
  _SalesData('13', 34),
  _SalesData('14', 32),
  _SalesData('15', 40),
  _SalesData('16', 40),
  _SalesData('17', 80),
  _SalesData('18', 80),
  _SalesData('19', 80),
  _SalesData('20', 80),
  _SalesData('21', 35),
  _SalesData('22', 28),
  _SalesData('23', 34),
  _SalesData('24', 32),
  _SalesData('25', 40),
  _SalesData('26', 40),
  _SalesData('27', 80),
  _SalesData('28', 80),
  _SalesData('29', 80),
  _SalesData('30', 80),
];
List<Employee> getEmployeeData() {
  return [
    Employee(10001, 'James', 'Project Lead', 20000),
    Employee(10002, 'Kathryn', 'Manager', 30000),
    Employee(10003, 'Lara', 'Developer', 15000),
    Employee(10004, 'Michael', 'Designer', 15000),
    Employee(10005, 'Martin', 'Developer', 15000),
    Employee(10006, 'Newberry', 'Developer', 15000),
    Employee(10007, 'Balnc', 'Developer', 15000),
    Employee(10008, 'Perry', 'Developer', 15000),
    Employee(10009, 'Gable', 'Developer', 15000),
    Employee(10010, 'Grimes', 'Developer', 15000)
  ];
}

class _SalesData {
  _SalesData(this.day, this.sales);

  final String day;
  final double sales;
}

/// Custom business object class which contains properties to hold the detailed
/// information about the employee which will be rendered in datagrid.
class Employee {
  /// Creates the employee class with required details.
  Employee(this.id, this.name, this.designation, this.salary);

  /// Id of an employee.
  final int id;

  /// Name of an employee.
  final String name;

  /// Designation of an employee.
  final String designation;

  /// Salary of an employee.
  final int salary;
}

/// An object to set the employee collection data source to the datagrid. This
/// is used to map the employee data to the datagrid widget.
class EmployeeDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  EmployeeDataSource({required List<Employee> employeeData}) {
    _employeeData = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<int>(columnName: 'Date', value: e.id),
      DataGridCell<String>(columnName: 'Name', value: e.name),
      DataGridCell<String>(columnName: 'Shift', value: e.designation),
      DataGridCell<int>(columnName: 'Quantity', value: e.salary),
      // DataGridCell<int>(columnName: 'Fat', value: e.salary),
    ]))
        .toList();
  }

  List<DataGridRow> _employeeData = [];

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: Text(e.value.toString()),
          );
        }).toList());
  }
}