import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:myappflutter/detailsPage.dart';
import 'package:myappflutter/fetchMessage.dart';
import 'package:myappflutter/fetchNotif.dart';
import 'package:myappflutter/fetchReportCard.dart';
import 'package:myappflutter/fetchTasks.dart';
import 'package:myappflutter/messageDetailsPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskPage extends StatefulWidget {
  final SharedPreferences prefs;
  final Map<String, String> reqHeaders;


  const TaskPage({super.key, required this.prefs, required this.reqHeaders});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {

  late Future<Map<String, dynamic>> data;
  late Future<Map> pData;
  late Future<Map> mData;
  late Future<Map> nData;

  @override
  void initState() {
    super.initState();

    data = fetchArticles(widget.reqHeaders);
    mData = fetchMessages(widget.reqHeaders);
    pData = fetchPreviousT(widget.reqHeaders);
    nData = fetchNotifications(widget.reqHeaders);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: DefaultTabController(
      length: 4,
      child: Scaffold(
        bottomNavigationBar: const TabBar(tabs: [
          Tab(text: "TAREAS", icon: Icon(Icons.book)),
          Tab(text: "MENSAJES", icon: Icon(Icons.mail)),
          Tab(text: "CALIFICACIONES", icon: Icon(Icons.text_increase)),
          Tab(text: "NOTIFICACIONES", icon: Icon(Icons.notification_important)),
        ]),
        body: TabBarView(
          children: [
            DefaultTabController(
                length: 2,
                child: Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    title: const Text("Tareas"),
                    bottom: const TabBar(
                      tabs: [
                        Tab(text: "PENDIENTES"),
                        Tab(
                          text: "ANTERIORES",
                        )
                      ],
                    ),
                  ),
                  body: TabBarView(
                    children: [
                      FutureBuilder<Map<String, dynamic>>(
                          future: data,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  itemCount: snapshot.data!["response"].length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      child: ListTile(
                                        trailing: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primaryContainer),
                                          child: Padding(
                                            padding: const EdgeInsets.all(7.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  snapshot.data!["response"]
                                                          [index]
                                                          ["relative_due_date"]
                                                      .toString()
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                                  .colorScheme
                                                                  .brightness ==
                                                              Brightness.light
                                                          ? Colors.black
                                                          : Colors.white,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Icon(
                                                    color: Theme.of(context)
                                                                .colorScheme
                                                                .brightness ==
                                                            Brightness.light
                                                        ? Colors.black
                                                        : Colors.white,
                                                    Icons
                                                        .keyboard_arrow_right_sharp)
                                              ],
                                            ),
                                          ),
                                        ),
                                        leading:
                                            const Icon(size: 20, Icons.book),
                                        onTap: () {
                                          Navigator.of(
                                                  context)
                                              .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailsPage(
                                                          title: snapshot.data![
                                                                  "response"][
                                                                  index]["name"]
                                                              .toString(),
                                                          taskId: snapshot
                                                              .data!["response"]
                                                                  [index]["_id"]
                                                              .toString(), headers: widget.reqHeaders,)));
                                        },
                                        title: ConstrainedBox(
                                          constraints: BoxConstraints(
                                              maxWidth: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.6),
                                          child: Text(
                                            maxLines: 3,
                                            snapshot.data!["response"][index]
                                                    ["name"]
                                                .toString(),
                                          ),
                                        ),
                                        subtitle: Text(
                                            snapshot.data!["response"][index]
                                                ["course"]["name"]),
                                      ),
                                    );
                                  });
                            } else if (snapshot.hasError) {
                              return const Center(
                                  child: Column(
                                children: [
                                  Icon(size: 50, Icons.error),
                                  Text("Ha ocurrido un error")
                                ],
                              ));
                            }
                            return const Center(
                                child: CircularProgressIndicator());
                          }),
                      FutureBuilder<Map>(
                          future: fetchPreviousT(widget.reqHeaders),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  itemCount: snapshot.data!["response"].length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      child: ListTile(
                                        trailing: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primaryContainer),
                                          child: Padding(
                                            padding: const EdgeInsets.all(7.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  snapshot.data!["response"]
                                                          [index]
                                                          ["relative_due_date"]
                                                      .toString()
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                                  .colorScheme
                                                                  .brightness ==
                                                              Brightness.light
                                                          ? Colors.black
                                                          : Colors.white,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Icon(
                                                    color: Theme.of(context)
                                                                .colorScheme
                                                                .brightness ==
                                                            Brightness.light
                                                        ? Colors.black
                                                        : Colors.white,
                                                    Icons
                                                        .keyboard_arrow_right_sharp)
                                              ],
                                            ),
                                          ),
                                        ),
                                        leading:
                                            const Icon(size: 20, Icons.book),
                                        onTap: () {
                                          Navigator.of(
                                                  context)
                                              .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailsPage(
                                                          title: snapshot.data![
                                                                  "response"][
                                                                  index]["name"]
                                                              .toString(),
                                                          taskId: snapshot
                                                              .data!["response"]
                                                                  [index]["_id"]
                                                              .toString(), headers: widget.reqHeaders,)));
                                        },
                                        title: ConstrainedBox(
                                          constraints: BoxConstraints(
                                              maxWidth: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.6),
                                          child: Text(
                                            maxLines: 3,
                                            snapshot.data!["response"][index]
                                                    ["name"]
                                                .toString(),
                                          ),
                                        ),
                                        subtitle: Text(
                                            snapshot.data!["response"][index]
                                                ["course"]["name"]),
                                      ),
                                    );
                                  });
                            } else if (snapshot.hasError) {
                              return const Center(
                                  child: Column(
                                children: [
                                  Icon(size: 50, Icons.error),
                                  Text("Ha ocurrido un error")
                                ],
                              ));
                            }
                            return const Center(
                                child: CircularProgressIndicator());
                          }),
                    ],
                  ),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        pData = fetchPreviousT(widget.reqHeaders);
                      });
                    },
                    child: const Icon(Icons.refresh),
                  ),
                )),
            Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text("Mensajes"),
              ),
              body: FutureBuilder<Map>(
                  future: mData,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!["response"].length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                trailing: const Icon(
                                    Icons.keyboard_arrow_right_sharp),
                                leading: const Icon(Icons.email),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => MessageDetailsPage(
                                            title: snapshot.data!["response"]
                                                [index]["subject"],
                                            id: snapshot.data!["response"]
                                                [index]["_id"],
                                        headers: widget.reqHeaders,
                                          )));
                                },
                                title: ConstrainedBox(
                                  constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.6),
                                  child: Text(snapshot.data!["response"][index]
                                      ["subject"]),
                                ),
                                subtitle: Text(snapshot.data!["response"][index]
                                        ["sender"]["surname"] +
                                    " ".toString() +
                                    snapshot.data!["response"][index]["sender"]
                                        ["name"]),
                              ),
                            );
                          });
                    } else if (snapshot.hasError) {
                      return const Center(
                          child: Column(
                        children: [
                          Icon(size: 50, Icons.error),
                          Text("Ha ocurrido un error")
                        ],
                      ));
                    }
                    return const Center(child: CircularProgressIndicator());
                  }),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    mData = fetchMessages(widget.reqHeaders);
                  });
                },
                child: const Icon(Icons.refresh),
              ),
            ),
            Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text("Calificaciones"),
              ),
              body: FutureBuilder<Map>(
                  future: fetchReportCard(widget.reqHeaders),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Center(
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primaryContainer),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        "PROMEDIO GENERAL",
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 15),
                                    child: Text(
                                      snapshot.data!["response"]["year_summary"]
                                              ["average"]
                                          .toString(),
                                      style: TextStyle(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.light
                                              ? Colors.black
                                              : Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 40),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                              child: ListView.builder(
                                  itemCount: snapshot
                                      .data!["response"]["subjects"].length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      child: ListTile(
                                        trailing: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            snapshot.data!["response"]
                                                                    ["subjects"]
                                                                [index]
                                                            ["year_summary"]
                                                        ["average"] !=
                                                    null
                                                ? snapshot.data!["response"]
                                                        ["subjects"][index]
                                                        ["year_summary"]
                                                        ["average"]
                                                    .toString()
                                                : "SIN PROMEDIO",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? Colors.black
                                                  : Colors.white,
                                            ),
                                          ),
                                        ),
                                        title: Text(snapshot.data!["response"]
                                            ["subjects"][index]["name"]),
                                      ),
                                    );
                                  }))
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
                    }
                    return const Center(child: CircularProgressIndicator());
                  }),
            ),
            Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text("Notificaciones"),
              ),
              body: FutureBuilder<Map>(
                future: nData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!["response"].length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              onTap: () async {
                                Map mContent = await fetchNotifiContent(
                                    snapshot.data!["response"][index]["_id"], widget.reqHeaders);
                                if (snapshot.data!["response"][index]["type"] ==
                                    "score") {
                                  return showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Stack(
                                            children: [
                                              Text(
                                                  'CURSO: ${mContent["response"]["course"]["name"]} \n\n'
                                                  'CALIFICACIÓN: ${mContent["response"]["attribute"]["value"]}\n\n'
                                                  'ACTIVIDAD: ${mContent["response"]["attribute"]["label"]}')
                                            ],
                                          ),
                                        );
                                      });
                                } else if (snapshot.data!["response"][index]["type"] ==
                                    "comment"){
                                  return showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Stack(
                                            children: [
                                              Text(
                                                  'CURSO: ${mContent["response"]["course"]["name"]} \n'
                                                      'COMENTARIO: ${mContent["response"]["attribute"]["value"]}\n'
                                                      'ACTIVIDAD: ${mContent["response"]["attribute"]["label"]}')
                                            ],
                                          ),
                                        );
                                      });
                                }
                              },
                              trailing: Builder(
                                builder: (context) {
                                  if (snapshot.data!["response"][index]
                                          ["type"] ==
                                      "score") {
                                    return const Icon(
                                        Icons.keyboard_arrow_right_sharp);
                                  } else if (snapshot.data!["response"][index]
                                          ["type"] ==
                                      "comment") {
                                    return const Icon(Icons.message_outlined);
                                  } else {
                                    return const SizedBox.shrink();
                                  }
                                },
                              ),
                              leading: Icon(
                                Icons.add_alert_outlined,
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                              title: ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width *
                                            0.6),
                                child: Text(
                                  maxLines: 3,
                                  snapshot.data!["response"][index]["title"]
                                      .toString(),
                                  style: TextStyle(
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? Colors.black
                                          : Colors.white),
                                ),
                              ),
                            ),
                          );
                        });
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
                },
              ),
            )
          ],
        ),
      ),
    ));
  }
}
