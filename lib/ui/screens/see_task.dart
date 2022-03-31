import 'package:flutter/material.dart';
import '../../data/models/task.dart';

class SeeTask extends StatelessWidget {
  var serverCmd;
  late String futureType;

  SeeTask({Key? key, required this.serverCmd}) : super(key: key) {
    futureType = serverCmd.runtimeType.toString();
  }

  bool isType<T1, T2>() => T1 == T2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: futureType ==
                'Future<Task>' // I m not sure if this is a good practice, I couldnot compare types without toString(), I think maybe all Futures translate into Future<dynamic>?
            ? FutureBuilder<Task>(
                future: serverCmd,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("id: " + snapshot.data!.id.toString()),
                          Text("todo: " + snapshot.data!.todo),
                          Text("isDone: " + snapshot.data!.isDone.toString()),
                          Text("description: " + snapshot.data!.description),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                  }

                  return CircularProgressIndicator();
                },
              )
            : FutureBuilder<List<Task>>(
                future: serverCmd,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Text(snapshot.data![index].id.toString()),
                              subtitle: Text(snapshot.data![index].description),
                            );
                          });
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                  }
                  return CircularProgressIndicator();
                },
              ),
      ),
    );
  }
}
