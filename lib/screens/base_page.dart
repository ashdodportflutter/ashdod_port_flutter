
import 'package:ashdod_port_flutter/engine/engine.dart';
import 'package:ashdod_port_flutter/view_model/view_model_base.dart';
import 'package:flutter/material.dart';
import 'package:observers_manager/base_page.dart';

class AppBasePage<T extends AppBaseModel, VM extends AppViewModel<T>> extends BasePage<T, VM> {
  AppBasePage({required super.viewModel});

  @override
  State<AppBasePage<T, VM>> createState() => AppBasePageState();
}

class AppBasePageState<M extends AppBaseModel, VM extends AppViewModel<M>, T extends AppBasePage<M, VM>> extends BasePageState<M, VM, T> {
  Engine engine = Engine.instance;
   late M model;
   late VM viewModel;
  @override
  void initState() {
    super.initState();
    widget.viewModel.addObserver(this);
    model= widget.viewModel.model;
    viewModel=widget.viewModel;
  }

  @override
  void dispose() {
    viewModel.removeObserver(this);
    super.dispose();
  }



  Widget get body {
    return const Placeholder();
  }

  Widget get loader {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.black45,
      child: const Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(
            height: 20,
          ),
          Text(
            'Loading...',
            style: TextStyle(color: Colors.white, fontSize: 30),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          body,
         viewModel.model.isLoading ? loader : Container()
        ],
      ),
    );
  }

  @override
  onNotify([M? data]) {
    setState(() {

    });
  }
}
