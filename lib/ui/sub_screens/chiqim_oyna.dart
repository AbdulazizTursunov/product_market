import 'package:flutter/material.dart';
import 'package:product_market/data/model/chiqim_model.dart';

class ChiqimOyna extends StatefulWidget {
  const ChiqimOyna({super.key});

  @override
  State<ChiqimOyna> createState() => _ChiqimOynaState();
}

class _ChiqimOynaState extends State<ChiqimOyna> {
  List<Chiqim> listChiqim = [];

  _selectAll() {
    setState(() {
      listChiqim = Chiqim.obektlar.values.toList();
      listChiqim.sort((a, b) => a.tr);
    });
  }

  _obektChiqimModel() async {
    Chiqim.obektlar = (await Chiqim.service.select()).map(
      (key, value) => MapEntry(
        key,
        Chiqim.fromJson(value),
      ),
    );
    _selectAll();
  }

  @override
  void initState() {
    _obektChiqimModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Chiqim oyna"),
      ),
      body: ListView.builder(
        itemCount: listChiqim.length,
        itemBuilder: (context, index) {
          Chiqim item = listChiqim[index];
          return DecoratedBox(
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              title: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("nomi: ${item.nomi}"),
                      const Text("  ||"),
                      Text(
                        "sotildi: ${item.sotildiMiqdor}",
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item.time.toString().substring(0, 16)),
                      const Text("||"),
                      Text("price: ${item.sotildiPrice}"),
                    ],
                  ),
                ],
              ),
              onLongPress: () {
                item.delete();
                _selectAll();
              },
            ),
          );
        },
      ),
    );
  }
}
