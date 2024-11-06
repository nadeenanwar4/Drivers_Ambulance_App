import 'package:driver_ambulance/Models/history_model.dart';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../Assistants/assistantMethods.dart';

class HistoryItem extends StatelessWidget
{
  final HistoryModel history;
  HistoryItem({required this.history});

  @override
  Widget build(BuildContext context)
  {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  children: <Widget>[
                    Image.asset('images/pickicon.png',height: 16,width: 16,),
                    SizedBox(width: 18,),
                    Expanded(child: Container(child: Text(history.pickup!, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 18),),)),
                    SizedBox(width: 5,),

                    Text('${history.fares}Dh', style: TextStyle(fontFamily: 'Brand Bold', fontSize: 16,color: Colors.black)),
                  ],
                ),
              ),
              SizedBox(height: 8,),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Image.asset('images/desticon.png',height: 16,width: 16,),
                  SizedBox(width: 18,),

                  Text(history.dropOff!,overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 18),),
                ],
              ),
              SizedBox(height: 15,),

              Text(AssistantMethods.formatTripDates(history.createdAt!), style: TextStyle(color: Colors.grey),),

            ],
          )
        ],
      ),
    );
  }
}