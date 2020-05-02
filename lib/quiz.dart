import 'package:flutter/material.dart';

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  int currentQuestion = 0;
  int score = 0;
  var quiz = [
    {
      "title": "Who won Ballon D'OR 2019?",
      "answers": [
        {"answer": "Virgil Van Dijk", "Correct": false},
        {"answer": "Lionel Messi", "Correct": true},
        {"answer": "Cristiano Ronaldo", "Correct": false}
      ]
    },
    {
      "title": "Hakim Ziyech is the new player of which club?",
      "answers": [
        {"answer": "Chelsea", "Correct": true},
        {"answer": "Manchester United", "Correct": false},
        {"answer": "AS Roma", "Correct": false}
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: (this.currentQuestion >= quiz.length) ?

      Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Text(
              "Score : ${((score / quiz.length) * 100).round()}%",
      style: TextStyle(fontSize: 26, color: Colors.blue),
    ),
      RaisedButton(
        color: Colors.blue,
      onPressed: (){
          setState(() {
            this.currentQuestion=0;
            this.score=0;
          });
      },
        child: Text("Restart...",style: TextStyle(fontSize: 18),),
        textColor: Colors.white,

    )


                ],
              ))
           : ListView(
              children: <Widget>[
                ListTile(
                  title: Text('Question ${currentQuestion + 1}/${quiz.length}',
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.lightBlue,
                          fontWeight: FontWeight.bold)),
                ),
                ListTile(
                    title: Text(
                  quiz[currentQuestion]['title'],
                  style: TextStyle(fontSize: 24, color: Colors.black),
                )),
                ...(quiz[currentQuestion]['answers']
                        as List<Map<String, Object>>)
                    .map((answer) {
                  return ListTile(
                      title: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: RaisedButton(
                      onPressed: () {
                        setState(() {
                          if (answer['Correct'] == true) {
                            score++;
                          }
                          ++currentQuestion;
                        });
                      },
                      child: Text(
                        answer['answer'],
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      color: Colors.lightBlue,
                    ),
                  ));
                })
              ],
            ),
    );
  }
}
