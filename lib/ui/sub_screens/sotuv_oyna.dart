import 'package:flutter/material.dart';
import 'package:product_market/data/model/chiqim_model.dart';
import 'package:product_market/data/model/product_model.dart';
import 'package:product_market/data/model/qoldiq_model.dart';

class SotuvOyna extends StatefulWidget {
  const SotuvOyna({super.key});

  @override
  State<SotuvOyna> createState() => _SotuvOynaState();
}

class _SotuvOynaState extends State<SotuvOyna> {
  Map<num, num> countSellMap = {};
  List<Product> listProduct = [];
  Product productInfo = Product();
  int countSell = 0;

  selectAll() {
    setState(
      () {
        listProduct = Product.obektlar.values.toList();
        listProduct.sort((a, b) => a.tr);
      },
    );
  }

  productObekt() async {
    Qoldiq.obektlar = (await Qoldiq.service.select()).map(
      (key, value) => MapEntry(
        key,
        Qoldiq.fromJson(value),
      ),
    );
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
        centerTitle: true,
        title: const Text("Sotuv Oynasi"),
      ),
      body: ListView.builder(
        itemCount: listProduct.length,
        itemBuilder: (context, index) {
          productInfo = listProduct[index];

          return ListTile(
            title: Row(
              children: [
                Text("nomi: ${productInfo.nomi}"),
                const Spacer(),
                Text("sotiladigan narx: ${productInfo.sotNarx}"),
              ],
            ),
            subtitle: Row(
              children: [
                Text("miqdor: ${productInfo.miqdor}"),
                const Spacer(),
                Row(
                  children: [
                    _changeCount(),
                  ],
                )
              ],
            ),
            onTap: () {},
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Row(
          children: [
            Icon(Icons.sell_sharp),
            SizedBox(width: 10),
            Text("sotish")
          ],
        ),
        onPressed: () async {
          Chiqim chiqim = Chiqim();
          chiqim.nomi = productInfo.nomi;
          chiqim.trBoboChiqim = productInfo.tr;
          chiqim.time = DateTime.now();
          chiqim.sotildiPrice = productInfo.sotNarx * countSell;
          chiqim.sotildiMiqdor = countSell;
          await chiqim.insert();

          //sotuv oynasidagi miqdorni update qilish uchun;
          productInfo.miqdor = productInfo.miqdor - countSell;
          await productInfo.update();
          // selectAll();

          // qoldiq oyna uchun miqdorni update qilyapti;
          productInfo.qoldiq.qoldiq = productInfo.miqdor;
          await productInfo.qoldiq.update();
          selectAll();
          // countSellMap.clear();
          setState(
            () {
              countSell = 0;
            },
          );
        },
      ),
    );
  }

  Widget _changeCount() {
    return FittedBox(
      child: Row(
        children: [
          IconButton(
            onPressed: () =>
                setState(() => countSell != 0 ? countSell-- : countSell),
            icon: const Icon(Icons.remove),
          ),
          Text(countSell.toString()),
          IconButton(
            onPressed: () => setState(() => countSell++),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
