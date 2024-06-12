import 'package:hive/hive.dart';
import 'package:shortest_roud/main.dart';

late Box box;

findExactPath(List<List<int>> directions,
    int startPoint, int nodesCount ,) {
  if (directions[startPoint][0] == nodesCount) {
    return;
  } else {
    ROUTS.add(directions[startPoint]);
    findExactPath(
        directions, directions[startPoint][0], nodesCount);
  }
}
