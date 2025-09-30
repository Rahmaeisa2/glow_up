import 'package:flutter/material.dart';

import '../model/workout_model.dart';
class WorkoutDetailScreen extends StatefulWidget {
  final WorkoutModel workout;

  const WorkoutDetailScreen({super.key, required this.workout});

  @override
  State<WorkoutDetailScreen> createState() => _WorkoutDetailScreenState();
}

class _WorkoutDetailScreenState extends State<WorkoutDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        centerTitle: true,
        leading: InkWell(
          onTap: (){
            Navigator.maybePop(context);
          },
            child: Icon(Icons.arrow_back_ios_new_outlined,size: 23,)),
        title: Text(widget.workout.name,
        style: TextStyle(
          fontSize: 23,
        ),),
      ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
