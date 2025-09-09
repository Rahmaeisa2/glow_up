import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/services/local_cache.dart';
import '../../core/theming/app_color.dart';
import '../../core/widget/responsive.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> mealData = [];
  List<Map<String, dynamic>> mealHistory = [];
  bool hasSearched = false;

  Future<void> searchMeal() async {
    String query = _controller.text.trim();
    print("Searching for $query");

    final snapshot = await FirebaseFirestore.instance
        .collection("meals")
        .where('name', isEqualTo: query)
        .get();

    print("Documents found: ${snapshot.docs.length}");
    final results = snapshot.docs.map((doc) => doc.data()).toList();

    setState(() {
      hasSearched = true;
      mealData = results;
    });

    if (results.isNotEmpty) {
      mealHistory.addAll(results);
      await LocalCache.saveMeals(mealHistory);
      print("Meals found: ${mealData.length}");
    } else {
      print("No meal found for '$query'");
    }
  }

  @override
  void initState() {
    super.initState();
    LocalCache.getMeals().then((cachedMeals) {
      if (cachedMeals.isNotEmpty) {
        setState(() {
          mealHistory = cachedMeals;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
          ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 40, vertical: 50),
        child: Column(
          children: [
            TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: ColorsApp.primary),
                ),
                hintText: 'Enter meal name...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: searchMeal,
                ),
              ),
            ),
            const SizedBox(height: 26),
            Expanded(
              child: hasSearched
                  ? (mealData.isEmpty
                  ? const Center(child: Text('No results found'))
                  : ListView.builder(
                  itemCount: mealData.length,
                  itemBuilder: (context, index) {
                    final meal = mealData[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius:BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        title: Text(meal['name'] ?? 'No name' ,
                          style: GoogleFonts.aDLaMDisplay(
                            textStyle:  TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,),
                          ),),
                        subtitle: Text(

                            "Calories: ${meal['calories']} | protein: ${meal['protein'] }" ,
                          style: GoogleFonts.aDLaMDisplay(
                            textStyle:  TextStyle(
                              fontSize: 18,),
                          ),),
                      ),
                    );
                  }))
                  : const Center(child: Text('Search for a meal')),
            ),
          ],
        ),
      ),
    );
  }
}
