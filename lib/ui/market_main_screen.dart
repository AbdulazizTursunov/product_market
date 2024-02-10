// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:product_market/data/model/product_model.dart';
import 'package:product_market/data/model/qoldiq_model.dart';
import 'package:product_market/ui/sub_screens/chiqim_oyna.dart';
import 'package:product_market/ui/sub_screens/qoldiq_oyna.dart';

import 'sub_screens/sotuv_oyna.dart';

class MainMarket extends StatefulWidget {
  const MainMarket({super.key});

  @override
  State<MainMarket> createState() => _MainMarketState();
}

class _MainMarketState extends State<MainMarket> {
  List<Product> listProduct = [];
  TextEditingController nomiController = TextEditingController();
  TextEditingController kelNarxController = TextEditingController();
  TextEditingController sotNarxController = TextEditingController();
  TextEditingController miqdorControlelr = TextEditingController();
  Product itemProduct = Product();
  Qoldiq qoldiqO = Qoldiq();

  selectAll() {
    setState(() {
      listProduct = Product.obektlar.values.toList();
      listProduct.sort((a, b) => a.tr);
    });
  }

  productObekt() async {
    Product.obektlar = (await Product.service.select()).map(
      (key, value) => MapEntry(
        key,
        Product.fromJson(value),
      ),
    );
    selectAll();
  }

  @override
  void initState() {
    productObekt();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChiqimOyna(),
                  ),
                );
              },
              icon: const Icon(Icons.remove_circle_sharp)),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const QoldiqOyna(),
                    ));
              },
              icon: const Icon(Icons.add_chart_sharp)),
        ],
        title: const Text("Main Screen"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: listProduct.length,
        itemBuilder: (context, index) {
          itemProduct = listProduct[index];
          return ListTile(
            onLongPress: () async {
              await itemProduct.delete();
              selectAll();
            },
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("nomi: ${itemProduct.nomi}"),
                Text("kelgna narx: ${itemProduct.kelNarx}"),
                Text("sotiladigan narx: ${itemProduct.sotNarx}"),
                Row(
                  children: [
                    Text("miqdor: ${itemProduct.miqdor}"),
                    const Spacer(),
                    Text(
                        "time: ${itemProduct.time.toString().substring(0, 16)}"),
                  ],
                ),
                const Divider(),
              ],
            ),
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(width: 50),
          FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SotuvOyna(),
                ),
              );
            },
            label: const Row(
              children: [Icon(Icons.sell), SizedBox(width: 5), Text("sotuv")],
            ),
          ),
          FloatingActionButton.extended(
            heroTag: 1,
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    actions: [
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 50,
                        child: TextField(
                          controller: nomiController,
                          autofocus: true,
                          decoration: InputDecoration(
                              hintText: "nomi",
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              fillColor: Colors.blueAccent),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 50,
                        child: TextField(
                          controller: kelNarxController,
                          keyboardType: TextInputType.number,
                          autofocus: true,
                          decoration: InputDecoration(
                              hintText: "kelgan narx",
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              fillColor: Colors.blueAccent),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 50,
                        child: TextField(
                          controller: sotNarxController,
                          autofocus: true,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: "sotiladigan narx",
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              fillColor: Colors.blueAccent),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 50,
                        child: TextField(
                          controller: miqdorControlelr,
                          autofocus: true,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: "miqdor",
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              fillColor: Colors.blueAccent),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Spacer(),
                          SizedBox(
                            height: 50,
                            width: 200,
                            child: ElevatedButton(
                              onPressed: () async {
                                Product product = Product();
                                product.nomi = nomiController.text;
                                product.kelNarx = num.tryParse(kelNarxController.text) ?? 0;
                                product.sotNarx = num.tryParse(sotNarxController.text) ?? 0;
                                product.miqdor = num.tryParse(miqdorControlelr.text) ?? 0;
                                product.time = DateTime.now();
                                await product.insert();
                                selectAll();


                                // // Qoldiq tablega insert qilish uchun
                                qoldiqO.trBoboQoldiq = itemProduct.tr;
                                qoldiqO.nomi = nomiController.text;
                                qoldiqO.qoldiq = num.tryParse(miqdorControlelr.text) ?? 0;
                                await qoldiqO.insert();
                                setState(() {});
                                Navigator.of(context).pop();
                                _clearController();
                              },
                              child: const Text("Mahsulot qo'shish",
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ],
                  );
                },
              );
            },
            label: const Row(
              children: [Icon(Icons.add), SizedBox(width: 5), Text("qo'shish")],
            ),
          ),
        ],
      ),
    );
  }

  _clearController() {
    nomiController.clear();
    kelNarxController.clear();
    sotNarxController.clear();
    miqdorControlelr.clear();
  }

  @override
  void dispose() {
    nomiController.dispose();
    kelNarxController.dispose();
    sotNarxController.dispose();
    miqdorControlelr.dispose();
    super.dispose();
  }
}

