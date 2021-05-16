#include "calculator.h"

Calculator::Calculator(QObject *parent) : QObject(parent) //изначальное заполнение матрицы нулями
{
    for (auto it = data.begin(); it != data.end(); ++it) {
        it->fill(0);
    }
}

void Calculator::addValue(int rowKey, int colKey, QString value) {//получение однонго из коэффициентов и запись в матрицу
    cout << "Add value:" << value.toInt() << endl;
    data[rowKey-1][colKey-1] = value.toInt();
}

void Calculator::doCalculate() { //выполнение вычислений и получение ответов
    cout << "CALC" << data[0][0] << " " << data[2][3] << endl;
    int k = data[0][0]*data[1][1]*data[2][2]
            +data[1][0]*data[2][1]*data[0][2]
            +data[2][0]*data[0][1]*data[1][2]
            -data[0][2]*data[1][1]*data[2][0]
            -data[1][0]*data[0][1]*data[2][2]
            -data[0][0]*data[2][1]*data[1][2];

    cout << "K: " << k << endl;

    if (k == 0) {
        emit answerReady(0,0,0);
        return;
    }

    double x1,x2,x3;
    int k1 = data[0][3]*data[1][1]*data[2][2]
            +data[1][3]*data[2][1]*data[0][2]
            +data[2][3]*data[0][1]*data[1][2]
            -data[0][2]*data[1][1]*data[2][3]
            -data[1][3]*data[0][1]*data[2][2]
            -data[0][3]*data[2][1]*data[1][2];
    x1 = k1/k;
    int k2 = data[0][0]*data[1][3]*data[2][2]
            +data[1][0]*data[2][3]*data[0][2]
            +data[2][0]*data[0][3]*data[1][2]
            -data[0][2]*data[1][3]*data[2][0]
            -data[1][0]*data[0][3]*data[2][2]
            -data[0][0]*data[2][3]*data[1][2];
    x2 = k2/k;
    int k3 = data[0][0]*data[1][1]*data[2][3]
            +data[1][0]*data[2][1]*data[0][3]
            +data[2][0]*data[0][1]*data[1][3]
            -data[0][3]*data[1][1]*data[2][0]
            -data[1][0]*data[0][1]*data[2][3]
            -data[0][0]*data[2][1]*data[1][3];
    x3 = k3/k;


    emit answerReady(x1,x2,x3); //передача ответов
}
