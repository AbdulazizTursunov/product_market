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
            onPressed: () {},
            icon: const Icon(Icons.sms, color: Colors.blueAccent),
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.car_repair,
                color: Colors.green,
              ))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 130,
            width: 130,
            child: CircleAvatar(
              radius:100,
              child: Image.network(
                  "https://th.bing.com/th/id/OIG.MC3PObbEmuJhfsPJ8biQ"),
            ),
          ),
          const SizedBox(height: 10),
          Text("Abdulaziz Tursunov",
              style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 5),
          Text("+998 94 203 93 77",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 20),
          const Text("Ismi"),
          Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueGrey,width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text("Abdulaziz Tursunov",
                  style: Theme.of(context).textTheme.headlineSmall),
            ),
          ),
        ],
      ),
    );
  }
}
