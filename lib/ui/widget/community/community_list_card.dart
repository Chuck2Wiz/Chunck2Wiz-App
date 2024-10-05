import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommunityListCard extends StatelessWidget {
  final String title;
  final String content;
  final String date;
  final String nick;
  final int likeCount;

  const CommunityListCard({
    super.key,
    required this.title,
    required this.content,
    required this.date,
    required this.nick,
    required this.likeCount
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, -1),
            blurRadius: 3,
            spreadRadius: 5,
          )
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
          const SizedBox(height: 8,),
          Text(content, style: const TextStyle(fontSize: 12, color: Colors.grey, overflow: TextOverflow.ellipsis,),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(date),
              Text("$likeCount"),
            ],
          )
        ],
      ),
    );
  }
}