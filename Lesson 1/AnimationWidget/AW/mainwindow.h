#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>

QT_BEGIN_NAMESPACE
namespace Ui { class MainWindow; }
QT_END_NAMESPACE

class MainWindow : public QMainWindow
{
    Q_OBJECT

    Q_PROPERTY(QColor color READ color WRITE setColor)

public:
    MainWindow(QWidget *parent = nullptr);
    ~MainWindow();
private slots:
    void on_authorization_clicked();

private:
    Ui::MainWindow *ui;

    QString login = "login";
    QString password = "password";
    QColor m_color;
    bool check();
    const QColor &color() const {return m_color;};
    void setColor(const QColor &newColor);
};
#endif // MAINWINDOW_H
