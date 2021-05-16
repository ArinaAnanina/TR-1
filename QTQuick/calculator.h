#ifndef CALCULATOR_H
#define CALCULATOR_H

#include <iostream>
#include <array>
#include <string>
#include <QString>
#include <QObject>
#include <QString>

using namespace std;

using Arr = array<array<int, 4>, 3>;
Q_DECLARE_METATYPE(Arr)

class Calculator : public QObject
{
    Q_OBJECT
public:
    Arr data;
    explicit Calculator(QObject *parent = nullptr);

signals:
    void answerReady(double ans1,double ans2, double ans3);

public slots:
    void doCalculate();
    void addValue(int rowKey, int colKey, QString value);
};

#endif // CALCULATOR_H
