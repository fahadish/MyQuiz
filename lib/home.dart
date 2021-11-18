import 'package:flutter/material.dart';
import 'package:quizz/answer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Icon> _scoreTracker = [];
  int _questionIndex = 0;
  int _totalScore = 0;
  bool answerWasSelected = false;
  bool endOfQuiz = false;
  bool correctAnswerSelected = false;

  void _questionAnswer(bool answerScore) {
    setState(() {
      answerWasSelected = true;
      if (answerScore) {
        _totalScore++;
        correctAnswerSelected = true;
      }
      _scoreTracker.add(answerScore
          ? const Icon(
              Icons.check_circle,
              color: Colors.green,
            )
          : const Icon(
              Icons.clear,
              color: Colors.red,
            ));
      if (_questionIndex + 1 == _questions.length) {
        endOfQuiz = true;
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      _questionIndex++;
      answerWasSelected = false;
      correctAnswerSelected = false;
    });
    if (_questionIndex >= _questions.length) {
      _restartQuiz();
    }
  }

  void _restartQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
      _scoreTracker = [];
      endOfQuiz = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mentor Quiz App',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                if (_scoreTracker.isEmpty)
                  const SizedBox(
                    height: 25.0,
                  ),
                if (_scoreTracker.isNotEmpty) ..._scoreTracker
              ],
            ),
            Container(
              width: double.infinity,
              height: 130.0,
              margin:
                  const EdgeInsets.only(bottom: 10.0, left: 30.0, right: 30.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Center(
                child: Text(
                  _questions[_questionIndex]['question'].toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white, fontStyle: FontStyle.italic),
                ),
              ),
            ),
            ...(_questions[_questionIndex]['answers']
                    as List<Map<String, dynamic>>)
                .map((answer) => Answer(
                      answerText: answer['answerText'].toString(),
                      answerColor: answerWasSelected
                          ? answer['score'] != false
                              ? Colors.green
                              : Colors.red
                          : Colors.white,
                      answerTap: () {
                        if (answerWasSelected) {
                          return;
                        }
                        _questionAnswer(answer['score']);
                      },
                    )),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 40.0),
                ),
                onPressed: () {
                  if (!answerWasSelected) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            'Please Selected an answer before going to next Question')));
                    return;
                  }
                  _nextQuestion();
                },
                child: Text(endOfQuiz ? 'Restart Quiz' : 'Next Question')),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                '$_totalScore/${_questions.length}',
                style: const TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (answerWasSelected && !endOfQuiz)
              Container(
                height: 100,
                width: double.infinity,
                color: correctAnswerSelected ? Colors.green : Colors.red,
                child: Center(
                  child: Text(
                    correctAnswerSelected
                        ? 'Well done, you got it right !'
                        : 'Wrong :/ ',
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            if (endOfQuiz)
              Container(
                height: 100,
                width: double.infinity,
                color: Colors.black,
                child: Text(
                  _totalScore > 4
                      ? 'Congratulation! Your Final Score is : $_totalScore'
                      : 'Your Final Score is $_totalScore. Better Luck Next Time! ',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: _totalScore > 4 ? Colors.green : Colors.red),
                ),
              )
          ],
        ),
      ),
    );
  }
}

const _questions = [
  {
    'question': 'How long is New Zealand’s Ninety Mile Beach?',
    'answers': [
      {'answerText': '88km, so 55 miles long.', 'score': true},
      {'answerText': '55km, so 34 miles long.', 'score': false},
      {'answerText': '90km, so 56 miles long.', 'score': false},
    ],
  },
  {
    'question':
        'In which month does the German festival of Oktoberfest mostly take place?',
    'answers': [
      {'answerText': 'January', 'score': false},
      {'answerText': 'October', 'score': false},
      {'answerText': 'September', 'score': true},
    ],
  },
  {
    'question': 'Who composed the music for Sonic the Hedgehog 3?',
    'answers': [
      {'answerText': 'Britney Spears', 'score': false},
      {'answerText': 'Timbaland', 'score': false},
      {'answerText': 'Michael Jackson', 'score': true},
    ],
  },
  {
    'question': 'In Georgia (the state), it’s illegal to eat what with a fork?',
    'answers': [
      {'answerText': 'Hamburgers', 'score': false},
      {'answerText': 'Fried chicken', 'score': true},
      {'answerText': 'Pizza', 'score': false},
    ],
  },
  {
    'question':
        'Which part of his body did musician Gene Simmons from Kiss insure for one million dollars?',
    'answers': [
      {'answerText': 'His tongue', 'score': true},
      {'answerText': 'His leg', 'score': false},
      {'answerText': 'His butt', 'score': false},
    ],
  },
  {
    'question': 'In which country are Panama hats made?',
    'answers': [
      {'answerText': 'Ecuador', 'score': true},
      {'answerText': 'Panama (duh)', 'score': false},
      {'answerText': 'Portugal', 'score': false},
    ],
  },
  {
    'question': 'From which country do French fries originate?',
    'answers': [
      {'answerText': 'Belgium', 'score': true},
      {'answerText': 'France (duh)', 'score': false},
      {'answerText': 'Switzerland', 'score': false},
    ],
  },
  {
    'question': 'Which sea creature has three hearts?',
    'answers': [
      {'answerText': 'Great White Sharks', 'score': false},
      {'answerText': 'Killer Whales', 'score': false},
      {'answerText': 'The Octopus', 'score': true},
    ],
  },
  {
    'question': 'Which European country eats the most chocolate per capita?',
    'answers': [
      {'answerText': 'Belgium', 'score': false},
      {'answerText': 'The Netherlands', 'score': false},
      {'answerText': 'Switzerland', 'score': true},
    ],
  },
];
