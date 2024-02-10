

import 'package:flutter/material.dart';


TextStyle style = const TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 18.0);
TextStyle subStyle = const TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16.0);



CounterRepo repo = CounterRepo();
class CounterRepo{
  int getCount(context,index){
    return SharedAppData.getValue(context, "count-$index", () => 5);
  }
  incrementCounter(context,index){
    var count = getCount(context, index);
    SharedAppData.setValue(context, "count-$index", count+1);
  }
  decrementCounter(context,index){
    var count = getCount(context, index);
    SharedAppData.setValue(context, "count-$index", count-1);
  }
}
