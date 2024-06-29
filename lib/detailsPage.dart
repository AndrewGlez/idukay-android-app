import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:myappflutter/taskDetailFetch.dart';
import 'package:intl/intl.dart';
import 'package:open_file_plus/open_file_plus.dart';

class DetailsPage extends StatefulWidget {
  final String title;
  final String taskId;
  final Map<String, String> headers;

  const DetailsPage({super.key, required this.title, required this.taskId, required this.headers});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: ListView(
        children: [
          FutureBuilder(
              future: taskDetailFetch(widget.headers,widget.taskId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Intl.defaultLocale = 'es';
                  int epochSeconds =
                      snapshot.data!["response"][0]["start_date"];
                  DateTime dateTimeFromEpochSeconds =
                      DateTime.fromMillisecondsSinceEpoch(epochSeconds * 1000);
                  String formattedDate =
                      DateFormat.yMMMd().format(dateTimeFromEpochSeconds);
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text(
                                    "ENVIADO EL",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).brightness ==
                                                Brightness.light
                                            ? Colors.black
                                            : Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(formattedDate),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              children: [


                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.timelapse,
                                          size: 50,
                                          color: snapshot.data!["response"][0]["remaining_days"] < 0 ? Colors.red : Colors.green,
                                        ),
                                        Text(
                                          "${snapshot.data!["response"][0]["remaining_days"]}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 30,
                                              color: snapshot.data!["response"][0]["remaining_days"] < 0 ? Colors.red : Colors.green)
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "días para entregar",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: snapshot.data!["response"][0]["remaining_days"] < 0 ? Colors.red : Colors.green),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Divider(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 1),
                        child: Text(
                          "DESCRIPCIÓN",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,fontSize: 20,color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.black
                                  : Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: SelectionArea(
                          child: HtmlWidget(
                            snapshot.data!["response"][0]["description"],
                          ),
                        ),
                      ),
                      //Padding(padding: const EdgeInsets.all(2), child: FilledButton(onPressed: () {}, child: const Text("Entregar")),),
                      const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Divider(),
                      ),
                      GridView.builder(
                          padding: const EdgeInsets.all(10),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 1,
                                  mainAxisSpacing: 10.0,
                                  crossAxisSpacing: 10.0),
                          itemCount: snapshot
                              .data!["response"][0]["attachments"].length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                FileDownloader.downloadFile(
                                    url: "https://idukay.net/api/" +
                                        snapshot.data!["response"][0]
                                            ["attachments"][index]["path"],
                                    name: snapshot.data!["response"][0]
                                        ["attachments"][index]["name"],
                                    onDownloadCompleted: (String path) {
                                      OpenFile.open(path);
                                    });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.attach_file,
                                      size: 50,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                    Text(
                                      snapshot.data!["response"][0]
                                              ["attachments"][index]["name"]
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.03),
                                    )
                                  ],
                                ),
                              ),
                            );
                          })
                    ],
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                      child: Column(
                    children: [
                      Icon(size: 50, Icons.error),
                      Text("Ha ocurrido un error")
                    ],
                  ));
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })
        ],
      ),
    );
  }
}
