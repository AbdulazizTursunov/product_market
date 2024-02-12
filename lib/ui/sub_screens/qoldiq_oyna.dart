import 'package:flutter/material.dart';
import 'package:product_market/data/model/qoldiq_model.dart';

class QoldiqOyna extends StatefulWidget {
  const QoldiqOyna({super.key});

  @override
  State<QoldiqOyna> createState() => _QoldiqOynaState();
}

class _QoldiqOynaState extends State<QoldiqOyna> {
  List<Qoldiq> listQoldiq = [];

  _selectAll() {
    setState(
      () {
        listQoldiq = Qoldiq.obektlar.values.toList();
        listQoldiq.sort((a, b) => a.tr);
      },
    );
  }

  _obektQoldiqModel() async {
    Qoldiq.obektlar = (await Qoldiq.service.select()).map(
      (key, value) => MapEntry(
        key,
        Qoldiq.fromJson(value),
      ),
    );
    _selectAll();
  }

  @override
  void initState() {
    _obektQoldiqModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: Drawer(child: Text('data'),backgroundColor: Colors.white.withOpacity(0.5),),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Qoldiq oyna"),
      ),
      body: ListView.builder(
        itemCount: listQoldiq.length,
        itemBuilder: (context, index) {
          Qoldiq item = listQoldiq[index];
          return ListTile(
            onLongPress: () {
              item.delete();
              _selectAll();
              setState(() {});
            },
            title: Row(
              children: [
                Text("nomi: ${item.nomi}"),
                const Spacer(),
                Text(
                  "qoldiq: ${item.qoldiq}",
                ),
              ],
            ),
            subtitle: Text(
              "№ ${item.tr}",
            ),
          );
        },
      ),
    );
  }
}

class QoldiqOynaOne extends StatefulWidget {
  const QoldiqOynaOne({super.key});

  @override
  State<QoldiqOynaOne> createState() => _QoldiqOynaOneState();
}

class _QoldiqOynaOneState extends State<QoldiqOynaOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Q O L D I Q   O Y N A"),
        centerTitle: true,
      ),
    );
  }
}
