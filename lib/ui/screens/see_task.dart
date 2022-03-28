import 'package:flutter/material.dart';
import '../../models/task.dart';

class SeeTask extends StatelessWidget {
  var serverCmd;
  String cmd;
  SeeTask({Key? key, required this.serverCmd, required this.cmd})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child:

            // unComment next section

            // cmd != "Get All"
            //     ?
            
            FutureBuilder<Task>(
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

        // unComment next section

        // : FutureBuilder<TaskList>(
        //     future: serverCmd,
        //     builder: (context, snapshot) {
        //       if (snapshot.connectionState == ConnectionState.done) {
        //         if (snapshot.hasData) {
        //           return Column(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: List.generate(serverCmd.length,
        //                 (index) => textsList(snapshot, index)),
        //           );
        //         } else if (snapshot.hasError) {
        //           return Text("${snapshot.error}");
        //         }
        //       }
        //       return CircularProgressIndicator();
        //     },
        //   ),
        );
  }
}

// unComment next section

// Widget textsList(snapshot, int n) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(vertical: 10),
//     child: Column(
//       children: [
//         Text("id: " + snapshot.data!.tasksList[n].id.toString()),
//         Text("todo: " + snapshot.data!.tasksList[n].todo),
//         Text("isDone: " + snapshot.data!.tasksList[n].isDone.toString()),
//         Text("description: " + snapshot.data!.tasksList[n].description),
//       ],
//     ),
//   );
// }
