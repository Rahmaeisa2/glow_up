import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/services/local_cache.dart';
import '../../../core/theming/app_color.dart';
import '../../../core/widget/responsive.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> mealData = [];
  List<String> mealHistory = [];
  bool hasSearched = false;
  Timer? _debounce;

  Future<List<Map<String, dynamic>>> searchMeal() async {
    String query = _controller.text.trim();
    print("Searching for $query");

    if (!mealHistory.contains(query) && query.isNotEmpty) {
      mealHistory.add(query);
      await LocalCache.saveMeals(mealHistory.map((e) => {'query': e}).toList());
    }

    final snapshot = await FirebaseFirestore.instance
        .collection("meals")
        .where('name', isGreaterThanOrEqualTo: query.toLowerCase())
        .where('name', isLessThanOrEqualTo: query + '\uf8ff')
        .get();

    print("Documents found: ${snapshot.docs.length}");
    final results = snapshot.docs.map((doc) => doc.data()).toList();

    setState(() {
      hasSearched = true;
      mealData = results;
    });

    if (results.isNotEmpty) {
      print("Meals found: ${mealData.length}");
    } else {
      print("No meal found for '$query'");
    }
    return results;
  }
  Future<void> getRecommendedMeals() async {
    final snapshot = await FirebaseFirestore.instance
        .collection("meals")
        .where("isRecommended", isEqualTo: true)
        .get();

    final recommended = snapshot.docs.map((doc) => doc.data()).toList();
    setState(() {
      mealData = recommended;
      hasSearched = true;
    });
  }

  void onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      searchMeal();
    });
  }
  @override
  void initState() {
    super.initState();
    getRecommendedMeals();
    if(_controller.text.isEmpty){
      getRecommendedMeals();
    }else{
      searchMeal();
    }
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Search"),

      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
        child: Column(
          children: [
            TextFormField(
              onChanged: onSearchChanged,
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:  BorderSide(color:Theme.of(context).colorScheme.primary),
                ),
                hintText: 'Enter meal name...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: searchMeal,
                ),
              ),
            ),
            SizedBox(height: 12,),
            ElevatedButton(onPressed: ()async{
                await LocalCache.clearMeals();
          setState(() {
    mealHistory.clear();
    });
              print("History cleared!");
              },
              child: Text("Clear Search History"),
            ),

            const SizedBox(height: 26),
            const SizedBox(height: 20),
            Expanded(
              child: hasSearched
                  ? (mealData.isEmpty
                  ? const Center(child: Text('No results found'))
                  : ListView.builder(
                  itemCount: mealData.length,
                  itemBuilder: (context, index) {
                    final meal = mealData[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(

                        color: Colors.grey[100],
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(15),

                      ),
                      child: ListTile(
                        title: Text(
                          meal['name'] ?? 'No name',
                          style: GoogleFonts.aDLaMDisplay(
                            textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        subtitle: Text(
                          "Calories: ${meal['calories']} | Protien: ${meal['protien']}",
                          style: GoogleFonts.aDLaMDisplay(
                            textStyle: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
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