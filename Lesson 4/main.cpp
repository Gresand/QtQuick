#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QApplication>

#include "graphicsmodel.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    //регистрируем класс
    qmlRegisterType<GraphicsModel>("GraphicsModel", 1, 0, "GraphicsModel");

    engine.load(url);

    return app.exec();
}
