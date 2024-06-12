import '../models/node.dart';

Map<String, dynamic> createDataStructure(List<String> input) {
  //! represent: the location of current character of input that we are anlyzing
  int index = 0;
  //! represent: how many times we want to stop :
  int stopCounts = int.parse(input[index]);

  index++;
  //! represent: that each time we stop , how many Stop bases we have as option to stop.
  List<int> stopBases = [];
  for (; index <= stopCounts; index++) {
    stopBases.add(int.parse(input[index]));
  }
  //! represent: how many StopBases We have overAll .
  int nodesCount = 0;
  for (int i = 0; i < stopBases.length; i++) {
    nodesCount += stopBases[i];
  }
  //! represent: List Of StopBases .
  List<Node> nodesList = [];
  for (int i = 0; i <= nodesCount + 1; i++) {
    Node node = Node(number: i);
    nodesList.add(node);
  }
  //! represent: cost of moving from each stop base from other stop base DIRECTLY .
  //? value 1000000 means there is no dirct way from this two stopBases.
  List<List<int>> matrix = List.generate(
    nodesCount + 2,
    (i) => List.generate(nodesCount + 2, (j) => 1000000),
  );
  while (input[index] != "") {
    int src = int.parse(input[index]);
    index++;
    int dis = int.parse(input[index]);
    index++;
    int val = int.parse(input[index]);
    index++;
    matrix[src][dis] = val * 50;
  }
  index++;
  //! find the best hotel for each Node.
  for (int i = 0; i < nodesCount; i++) {
    int currentNodeNumber = int.parse(input[index]);
    index++;
    List<int> currentHotelCosts = [];
    while (input[index] != '.') {
      currentHotelCosts.add(int.parse(input[index]));
      index++;
    }
    index++;
    nodesList[currentNodeNumber].findBestHotel(currentHotelCosts);
  }
  /*this algorithm is a Copy of multi Level Graph problem
  //we need a single  distanation at last layer 
  so we create a extra index in matrix and allocating 0 as cost of
  each rout that ends with this base
  ex : if stopbase count is 12 we need node no.13 in matrix to compelete algorithem
  */
  int lastLayer = stopBases[stopCounts - 1];
  for (int i = nodesCount; i > (nodesCount - lastLayer); i--) {
    matrix[i][nodesCount + 1] = 0;
  }
  //! NOTE: we need matrix for rout costs and nodes for hotel expenses
  Map<String, dynamic> output = {"matrix": matrix, "nodes": nodesList};
  return output;
}
