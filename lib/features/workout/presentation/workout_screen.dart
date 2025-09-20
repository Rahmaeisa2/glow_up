import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/services/workout_service.dart';
import '../data/workouts_data.dart';
import '../model/workout_model.dart';
import '../widget/workout_card.dart';
import 'package:flutter/material.dart';
class WorkoutScreen extends StatefulWidget {
  final String muscleName;
  const WorkoutScreen({super.key, required this.muscleName});

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WorkoutService().addWorkoutsIfNotExists(Workouts);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: InkWell(
          onTap: (){
            Navigator.maybePop(context);
          },
          child: Icon(Icons.arrow_back_ios_new_outlined,
          size: 24,),
        ),
        title: Text(widget.muscleName,style: GoogleFonts.aDLaMDisplay(
        textStyle: const TextStyle(fontSize: 20),)),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('workout')
            .where('muscle', isEqualTo: widget.muscleName)
            // خدي من widget
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No workouts found"));
          }
          print("Docs: ${snapshot.data!.docs.map((d) => d.data())}");


          List<WorkoutModel> workouts = snapshot.data!.docs
              .map((doc) => WorkoutModel.fromMap(
              doc.data() as Map<String, dynamic>, doc.id))
              .toList();


          return GridView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: workouts.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (context, index) {
              final workout = workouts[index];
              return WorkoutCard(
                workout: workout,
                onTap: () {
                },
              );
            },
          );
        },
      ),
    );
  }
}
