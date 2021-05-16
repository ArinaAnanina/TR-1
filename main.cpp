#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QQmlContext>
#include "calculator.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QQuickStyle::setStyle("Material"); //дизайн

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(
                &engine, &QQmlApplicationEngine::objectCreated,
                &app, [url](QObject *obj, const QUrl &objUrl) {
                            if (!obj && url == objUrl)
                                QCoreApplication::exit(-1);
                        },
    Qt::QueuedConnection);
    qmlRegisterType<Calculator>("calculator", 1, 0, "Calculator"); //чтение класса Калькулятор
    engine.load(url);
    return app.exec();
}


/*

 * без рамочки flags: Qt.FramelessWindowHint

Система уравнений с тремя неизвестными (задаются коэффициенты).
Ввод, хранение уравнений в памяти (до 4 систем), вычисление неизвестных

*/
