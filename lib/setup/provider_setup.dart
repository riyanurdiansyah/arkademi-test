import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:test_arkademi/provider/home_provider.dart';

List<SingleChildStatelessWidget> providers = [
  ...independentServices,
  ...dependentServices,
];

List<SingleChildStatelessWidget> independentServices = [
  ChangeNotifierProvider(create: (context) => HomeProvider()),
];

List<SingleChildStatelessWidget> dependentServices = [];

abstract class BaseProvider implements SingleChildStatelessWidget {}
