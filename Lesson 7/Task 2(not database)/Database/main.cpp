#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <datamodel.h>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    dataModel model;
    model.appendRowElement(dataModel::RowElement{1, "Ivan", "Ivanov", {"Sergey", "Egor"}});
    model.appendRowElement(dataModel::RowElement{1, "Egor", "Dickov", {"Ivan", "Nastya"}});
    model.appendRowElement(dataModel::RowElement{1, "Stepa", "Stepkov", {"Egor", "Alexandr"}});

    engine.rootContext()->setContextProperty("mdl",&model);

    engine.load(url);

    return app.exec();
}
