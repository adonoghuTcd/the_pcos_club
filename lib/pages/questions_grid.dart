// import 'package:flutter/material.dart';
//
// import '../providers/products.dart';
// import './product_item.dart';
//
// class QuestionsGrid extends StatelessWidget {
//   String symptom;
//   QuestionsGrid(this.symptom);
//
//   @override
//   Widget build(BuildContext context) {
//    return GridView.builder(
//       padding: const EdgeInsets.all(10.0),
//       itemCount: products.length,
//       itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
//         // builder: (c) => products[i],
//         value: products[i],
//         child: ProductItem(
//           // products[i].id,
//           // products[i].title,
//           // products[i].imageUrl,
//         ),
//       ),
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         childAspectRatio: 3 / 2,
//         crossAxisSpacing: 10,
//         mainAxisSpacing: 10,
//       ),
//     );
//   }
// }
