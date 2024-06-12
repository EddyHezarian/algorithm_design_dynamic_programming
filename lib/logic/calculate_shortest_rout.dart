import '../models/node.dart';

calculateShortestRout(Map<String, dynamic> data) {
  //! Extracting data from input of Function
  List<Node> stopBaseList = data['nodes'];
  List<List<int>> matrix = data['matrix'];
  //! represent: the best cost from Each Base to Distanation.
  //? index 0 represnt Best cost from src from distanation : ANSWER
  List<int> bestCosts = List.generate(stopBaseList.length, (j) => 0);

  int nodeCount = bestCosts.length - 1;

  //! represent: the best Next base for Each Base
  //? we need a secondary algorithem to find Exact path from src to dist
  List<List<int>> directions =
      List.generate(stopBaseList.length, (j) => [0, 0]);

  ///-----------------------------ALGORITHM----------------------------
  bestCosts[nodeCount] = 0;
  for (int i = nodeCount - 1; i >= 0; i--) {
    bestCosts[i] = 1000000;
    for (int k = 0; k <= nodeCount; k++) {
      int hotelCosts = stopBaseList[i].minHotelCost!;
      int hotelIndex = stopBaseList[i].hotelIndex!;
      int cost = (matrix[i][k] + bestCosts[k]) + hotelCosts;
      if (cost < bestCosts[i]) {
        bestCosts[i] = (((matrix[i][k] + bestCosts[k])) + hotelCosts);
        directions[i] = [k, hotelIndex];
      }
    }
  }

  ///------------------------------------------------------------------
  
  //! represent: the final Answer Format Format For UI
  Map<String, dynamic> response;
  response = {
    "NodeCount":nodeCount,
    "MinCost": bestCosts[0],
    "Rout": directions,
    "Nodes": stopBaseList,
  };

  return response;
}
