import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ShowDialog extends StatelessWidget {
  const ShowDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CircleAvatar(
          radius: BorderSide.strokeAlignCenter,
          child: Icon(
            Icons.menu,
            color: Colors.teal,
          ),
        ),
        centerTitle: true,
        title: const Text("P R O F I L E"),
        actions: [
          IconButton(
            onPressed: () {
              if (kDebugMode) {
                print("hammasini amalga oshirish kerak");
              }
            },
            icon: const Icon(Icons.sms, color: Colors.blueAccent),
          ),
          IconButton(
              onPressed: () {
                if (kDebugMode) {
                  print(
                      """hayot tartibini o'zgartirish kerak.
                      Hammasini birdan olib ketish kerak.Faqat tezroq hal etish kerak hammasini
                      .Yaqinda o'g'il farzandlik bo'laman. Inshaallox uning ismini 'Abdullox' qo'yaman.
                      Uni umidvorlik bilan kutyapman.Xudo xoxlasa biz uni juda orzuqib ketyapman.
                      Faqat mengina emas uning onasi ham kutyapti.U hozir juda og'rib yuribdi.Unga raxmim kelyapti og'rigani uchun
                      """);
                }
              },
              icon: const Icon(
                Icons.car_repair,
                color: Colors.green,
              ))
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 130,
            width: 130,
            child: CircleAvatar(
              radius: 100,
              child: Image.network(
                  "https://th.bing.com/th/id/OIG.MC3PObbEmuJhfsPJ8biQ"),
            ),
          ),
          const SizedBox(height: 10),
          Text("Abdulaziz Tursunov",
              style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 5),
          Text(
            "+998 94 203 93 77",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 20),
          const Text("Ismi"),
          Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueGrey, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text("Abdulaziz Tursunov",
                  style: Theme.of(context).textTheme.headlineSmall),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 130,width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),

            ),
          ),
        ],
      ),
    );
  }
}
