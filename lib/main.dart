import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:shortest_roud/consts/consts.dart';
import 'package:shortest_roud/imports/create_data_structure_from_input.dart';
import 'package:shortest_roud/logic/calculate_shortest_rout.dart';
import 'package:shortest_roud/logic/find_exact_path.dart';

List<List<int>> ROUTS = [];
void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();

  String defultValues = Consts.defultValues;
  Map<String, dynamic> procceesedData = {};
  Map<String, dynamic> formatedInputData = {};
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dynamic Programming"),
        actions: [
          IconButton(
              onPressed: () {
                _controller.text = defultValues;
              },
              icon: const Icon(Icons.edit_note_outlined)),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProblemDefinetion()));
              },
              icon: const Icon(Icons.info_outline_rounded)),
        ],
      ),
      body: Column(
        children: [
          Title(color: Colors.black, child: const Text("Write your Data")),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLines: null,
                controller: _controller,
                decoration: const InputDecoration(
                  hintText:
                      'Wrute Your Data (See The Data Format In Info icon)',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          ROUTS.clear();
          List<String> splitedInputText =
              _controller.text.replaceAll("\n", " ").split(" ");
          formatedInputData = createDataStructure(splitedInputText);
          procceesedData = calculateShortestRout(formatedInputData);
          findExactPath(procceesedData["Rout"], 0, procceesedData["NodeCount"]);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ResultView(
                        procceseedData: procceesedData,
                      )));
        },
        child: const Icon(Icons.play_arrow_rounded),
      ),
    );
  }
}

class ResultView extends StatefulWidget {
  const ResultView({super.key, required this.procceseedData});
  final Map<String, dynamic> procceseedData;

  @override
  State<ResultView> createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("RESULT"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: [
                DelayedWidget(
                  delayDuration: const Duration(microseconds: 200),
                  animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.tertiaryContainer,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.home_rounded),
                  ),
                ),
                DelayedWidget(
                  delayDuration: const Duration(milliseconds: 150),
                  animation: DelayedAnimations.SLIDE_FROM_TOP,
                  child: Container(
                    margin: const EdgeInsets.all(1),
                    width: 4,
                    height: 70,
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: ROUTS.length,
            itemBuilder: (context, index) {
              int nodeNumber = ROUTS[index][0];
              int hotelndex = ROUTS[index][1];
              return index == ROUTS.length - 1
                  ? Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DelayedWidget(
                            delayDuration:
                                Duration(milliseconds: (index * 100) + 200),
                            animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
                            child: Container(
                              margin: const EdgeInsets.only(left: 35),
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .tertiaryContainer,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(child: Text(nodeNumber.toString())),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(4),
                            child: Icon(Icons.hotel),
                          ),
                          Text(hotelndex.toString())
                        ],
                      ),
                    )
                  : Center(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DelayedWidget(
                                delayDuration:
                                    const Duration(milliseconds: 200),
                                animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
                                child: Container(
                                  margin: const EdgeInsets.only(left: 35),
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                      child: Text(nodeNumber.toString())),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(4),
                                child: Icon(Icons.hotel),
                              ),
                              Text(hotelndex.toString())
                            ],
                          ),
                          DelayedWidget(
                            delayDuration:
                                Duration(milliseconds: (index * 100) + 200),
                            animation: DelayedAnimations.SLIDE_FROM_TOP,
                            child: Container(
                              margin: const EdgeInsets.all(1),
                              width: 4,
                              height: 70,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    );
            },
          )),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.1,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(10)),
            child: Center(
                child: Text(
              "OverAll Expenses : ${widget.procceseedData["MinCost"]}",
              style: const TextStyle(fontSize: 22, color: Colors.white),
            )),
          )
        ],
      ),
    );
  }
}

class ProblemDefinetion extends StatelessWidget {
  const ProblemDefinetion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Problem Definition"),
      ),
      body: Column(
        children: [

          Container(
            margin: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            child:  Text("Shortest Rout with Minimum Cost", style: TextStyle(color: Theme.of(context).colorScheme.primary , fontSize: 24 ),),
          ), 
          Container(
            margin: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            child: const Text(Consts.problemExplanation),
          ),
        ],
      ),
    );
  }
}
