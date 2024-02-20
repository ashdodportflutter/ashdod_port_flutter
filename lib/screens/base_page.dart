
import 'package:ashdod_port_flutter/engine/engine.dart';
import 'package:ashdod_port_flutter/view_model/view_model_base.dart';
import 'package:flutter/material.dart';
import 'package:observers_manager/observer.dart';

class BasePage<VM extends ViewModelBase> extends StatefulWidget {
  final VM viewModel;

  const BasePage({super.key, required this.viewModel});

  @override
  State<BasePage<VM>> createState() => BasePageState();
}

class BasePageState<T extends BasePage, M extends BaseModel> extends State<T> implements Observer<M> {
  Engine engine = Engine.instance;

  @override
  void initState() {
    super.initState();
    widget.viewModel.addObserver(this);
  }

  @override
  void dispose() {
    widget.viewModel.removeObserver(this);
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
          widget.viewModel.model.isLoading ? loader : Container()
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
