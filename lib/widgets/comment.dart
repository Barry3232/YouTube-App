import 'package:flutter/material.dart';

void showCommentsBottomSheet(BuildContext context){
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white54,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context){
        return DraggableScrollableSheet(
          expand: false,
            initialChildSize: 0.6,
            minChildSize: 0.3,
            maxChildSize: 0.95,
            builder: (context, scrollController){
              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 5,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                  )
                ],
              );
            });
      }
  );
}
