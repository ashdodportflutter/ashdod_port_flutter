import 'package:ashdod_port_flutter/screens/base_page.dart';
import 'package:ashdod_port_flutter/screens/presence_list_page/presence_list_view_model.dart';
import 'package:flutter/material.dart';

class PresenceListPage extends AppBasePage<PresenceModel, PresenceViewModel> {
  PresenceListPage({required super.viewModel});





  @override
  AppBasePageState<PresenceModel, PresenceViewModel, PresenceListPage> createState() => _PresenceListPageState();
}

class _PresenceListPageState extends AppBasePageState<PresenceModel, PresenceViewModel, PresenceListPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.separated(
          itemBuilder: (context, index) {
            var day = model.days?[index];
            return Column(children: [
              SizedBox(
                  height: 30,
                  child: Text(day?.month ?? '',
                      style: TextStyle(fontSize: 22, color: Colors.blue))),
              ListTile(
                leading: Container(
                  padding: EdgeInsets.only(top: 16),
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.red,
                      width: 5.0,
                    ),
                  ),
                  child: Text(
                    day?.dayPresent ?? '',
                    textAlign: TextAlign.center,
                  ),
                ),
                title: Column(children: [
                  Text(
                    '${day?.hourPresentArrived ?? ''} כניסה ',
                    style: TextStyle(fontSize: 20, color: Colors.green),
                  ),
                  Text(
                    '${day?.hourPresentLeft ?? ''} יציאה ',
                    style: TextStyle(fontSize: 20, color: Colors.red),
                  )
                ]),
                // subtitle: Text(day?.hourPresentLeft ?? ''),
              ),
            ]);
          },
          separatorBuilder: (context, index) {
            return Divider(
              thickness: 1,
              color: Colors.grey,
            );
          },
          itemCount: model.days?.length ?? 0),
    );
  }
}
