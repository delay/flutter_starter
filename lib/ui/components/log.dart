import 'package:flutter/material.dart';
import '../../services/services.dart';
import '../../services/helpers/helpers.dart';

class Log {
  static List<Widget> addCard(List<Widget> _widgets, List<Stat> _workoutStats,
      List<Widget> _workoutCard, List<Widget> _workoutHeader) {
    //print('Stat: ' + _workoutStats.length.toString());
    //print('Card: ' + _workoutCard.length.toString());
    //print('item: ' + _workoutCard[0].toString());
    //need to handle the list of workouts being in reverse order from date newest to oldest overall.
    List<Widget> _workoutCardReverse = _workoutCard.reversed.toList();
    _widgets.add(Card(
        color: Palette.logCardBackgroundColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _workoutHeader),
              SizedBox(height: 20),
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: _workoutCardReverse),
            ],
          ),
        )));
    return _widgets;
  }

  static Widget setItem(User user, Stat _workoutSet) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
      Stack(alignment: AlignmentDirectional.center, children: <Widget>[
        Align(
            alignment: Alignment.center,
            child: Container(
                width: 24,
                height: 24,
                decoration: new BoxDecoration(
                  color: Palette.logSetBackgroundColor,
                  borderRadius: new BorderRadius.circular(60.0),
                ))),
        Align(
          alignment: Alignment.center,
          child: Text(
            _workoutSet.series.toString(),
            style: TextStyle(
                color: Palette.logSetTextColor,
                fontSize: 14,
                fontWeight: FontWeight.bold),
          ),
        ),
      ]),
    ]);
  }

  static Widget setItemText(User user, Stat _workoutSet) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
      Text(
        '  ' +
            removeTrailing0(_workoutSet.weight.toString()) +
            ' ' +
            user.weightMeasurement +
            ' x ' +
            _workoutSet.reps.toString() +
            ' reps  ',
        style: TextStyle(
            color: Palette.logTextColor,
            fontSize: 14,
            fontWeight: FontWeight.normal),
      ),
      Log.setTime(user, _workoutSet)
    ]);
  }

  static Widget setRPE(User user, Stat _workoutSet) {
    Color _rPEColor = Global.rpeColor(_workoutSet.rpe);
    if (_workoutSet.rpe > 0) {
      return Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        Stack(alignment: AlignmentDirectional.center, children: <Widget>[
          Align(
              alignment: Alignment.center,
              child: Container(
                  width: 24,
                  height: 24,
                  decoration: new BoxDecoration(
                    color: _rPEColor,
                    borderRadius: new BorderRadius.circular(60.0),
                  ))),
          Align(
            alignment: Alignment.center,
            child: Text(
              _workoutSet.rpe.toString(),
              style: TextStyle(
                  color: Palette.logRPETextColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ]),
      ]);
    } else {
      return SizedBox(width: 24, height: 24);
    }
  }

  static Widget setNote(User user, Stat _workoutSet) {
    if (_workoutSet.note != '') {
      return Column(
        children: <Widget>[
          Divider(
            color: Palette.workoutDivider,
          ),
          SizedBox(height: 6.0),
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Set ' + _workoutSet.series.toString() + ' notes:  ',
                    style: TextStyle(
                        color: Palette.logTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold)),
                Flexible(
                  child: Container(
                    child: Text(_workoutSet.note,
                        style: TextStyle(
                            color: Palette.logTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.normal)),
                  ),
                )
              ]),
          SizedBox(height: 6.0),
          Divider(
            color: Palette.workoutDivider,
          ),
        ],
      );
    } else {
      return SizedBox(width: 24, height: 24);
    }
  }

  static Widget setTime(User user, Stat _workoutSet) {
    if (_workoutSet.duration != 0) {
      return Row(
        children: <Widget>[
          Container(
            width: 4,
            height: 4,
            decoration: new BoxDecoration(
              color: Palette.logSeparatorColor,
              shape: BoxShape.circle,
            ),
          ),
          Text(
            '  ' + formatSeconds(_workoutSet.duration.toInt()),
            style: TextStyle(
                color: Palette.logTextColor,
                fontSize: 14,
                fontWeight: FontWeight.normal),
          )
        ],
      );
    } else {
      return Text('');
    }
  }

  static Widget exerciseHeader(List<Exercise> _exercises, String _exerciseId) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 20),
        Text(
          _getExerciseName(_exercises, _exerciseId),
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Divider(
          height: 2,
          thickness: 2,
          color: Palette.black,
        ),
        SizedBox(height: 10),
      ],
    );
  }

  static String _getExerciseName(
      List<Exercise> _exercises, String _exerciseId) {
    String _exerciseName = '';
    _exercises.forEach((_exercise) {
      if (_exercise.id == _exerciseId) {
        _exerciseName = _exercise.name;
      }
    });
    return _exerciseName;
  }

  static String getWorkoutName(User user, String _workoutId) {
    String _workoutName = '';
    user.workouts.forEach((_workout) {
      if (_workout.id == _workoutId) {
        _workoutName = _workout.workoutName;
      }
    });
    return _workoutName;
  }

  static Widget closeButton(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        width: 32,
        height: 32,
        decoration: new BoxDecoration(
          color: Palette.whiteTransparent,
          borderRadius: new BorderRadius.circular(30.0),
        ),
        child: Icon(
          Icons.close,
          color: Palette.whiteLessTransparent,
          size: 20.0,
        ),
      ),
    );
  }
}
