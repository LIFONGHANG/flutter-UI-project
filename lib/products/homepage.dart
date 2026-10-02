import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ==========================================================
      // APP BAR
      // ==========================================================
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        toolbarHeight: 50,

        // Left icon
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
            size: 24,
          ),
        ),

        // Middle logo
        title: Image.asset(
          "assets/Images/logo/logoipsum-255 1.png",
          height: 35,
        ),

        centerTitle: true,

        // Right profile
        actions: [
          IconButton(
            onPressed: () {},
            icon: const CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage(
                "assets/Images/logo/2289_SkVNQSBGQU1PIDEwMjgtMTE2 1.png",
              ),
            ),
          ),
        ],
      ),

      // ==========================================================
      // BODY
      // ==========================================================
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),

        child: Column(
          children: [
            // ==================================================
            // SEARCH BAR
            // ==================================================
            const TextField(
              decoration: InputDecoration(
                hintText: "Search any products",

                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),

                suffixIcon: Icon(
                  Icons.mic_none,
                  color: Colors.grey,
                ),
              ),
            ),

            const SizedBox(height: 18),

            // ==================================================
            // ALL FEATURED
            // ==================================================
            Row(
              children: [
                const Text(
                  "All Featured",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),

                const Spacer(),

                // Sort button
                ElevatedButton.icon(
                  onPressed: () {},

                  icon: const Icon(
                    Icons.swap_vert,
                    size: 20,
                  ),

                  label: const Text("Sort"),

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    elevation: 1,

                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 2,
                    ),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                // Filter button
                ElevatedButton.icon(
                  onPressed: () {},

                  icon: const Icon(
                    Icons.filter_alt_outlined,
                    size: 20,
                  ),

                  label: const Text("Filter"),

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    elevation: 1,

                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 2,
                    ),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}