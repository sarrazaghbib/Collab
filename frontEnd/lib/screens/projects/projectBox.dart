import './project.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class projectBox {
  static final projectBox instance = projectBox();
  static Box box = box; //this may generate a bug

  static void init() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    Hive.registerAdapter(projectAdapter());
    box = await Hive.openBox("projectBox");
    var values = box.values;
    if (values == null || values.isEmpty) {
      projectBox.box.putAll(
          Map.fromIterable(projects, key: (e) => e.key(), value: (e) => e));
    }
  }

  static final List<project> projects = [
    project("Projet 1", "Par David Silvera", "plannification annuelle ", 10),
    project("projet 2", "Par Cyril Lignac", "Self driving car", 33),
    project("project 3", "Par Xavier", "investissement ", 13),
  ];
}
