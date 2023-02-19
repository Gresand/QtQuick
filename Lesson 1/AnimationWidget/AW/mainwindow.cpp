#include "mainwindow.h"
#include "ui_mainwindow.h"

#include <QPropertyAnimation>
#include <QSequentialAnimationGroup>
#include <QParallelAnimationGroup>
#include <QGraphicsOpacityEffect>

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    connect(ui->loginLine, SIGNAL(returnPressed()), ui->authorization, SIGNAL(clicked()));
    connect(ui->passwordLine, SIGNAL(returnPressed()), ui->authorization, SIGNAL(clicked()));
}

MainWindow::~MainWindow()
{
    delete ui;
}

bool MainWindow::check()
{
    return (ui->loginLine->text() == login &&
            ui->passwordLine->text() == password) ? true : false;
}

void MainWindow::setColor(const QColor &newColor)
{
    QString style = QString("QLineEdit {color: rgb(%1, %2, %3); }").
                    arg(newColor.red()).
                    arg(newColor.green()).
                    arg(newColor.blue());

    ui->loginLine->setStyleSheet(style);
    ui->passwordLine->setStyleSheet(style);

    m_color = newColor;
}


void MainWindow::on_authorization_clicked()
{
    if(check())
    {
        ui->loginLine->setEnabled(false);
        ui->passwordLine->setEnabled(false);
        ui->authorization->setEnabled(false);
        //Графический эффект для текстовых полей, не знаю как оба засунуть, срабатывает по последнему
        QGraphicsOpacityEffect* invisibleL = new QGraphicsOpacityEffect(this);
        invisibleL->setOpacity(1);
        ui->loginLine->setGraphicsEffect(invisibleL);
        QPropertyAnimation* invizeLineL = new QPropertyAnimation(invisibleL, "opacity", this);
        invizeLineL->setEndValue(0);
        invizeLineL->setDuration(400);
        QGraphicsOpacityEffect* invisibleP = new QGraphicsOpacityEffect(this);
        invisibleP->setOpacity(1);
        ui->passwordLine->setGraphicsEffect(invisibleP);
        QPropertyAnimation* invizeLineP = new QPropertyAnimation(invisibleP, "opacity", this);
        invizeLineP->setEndValue(0);
        invizeLineP->setDuration(400);
        QParallelAnimationGroup* line = new QParallelAnimationGroup(this);
        line->addAnimation(invizeLineL);
        line->addAnimation(invizeLineP);
        line->start(line->DeleteWhenStopped);
        //Для квадрата
        QGraphicsOpacityEffect* invisibleF = new QGraphicsOpacityEffect(this);
        invisibleF->setOpacity(1);
        ui->frame->setGraphicsEffect(invisibleF);
        QPropertyAnimation* invizeFrame = new QPropertyAnimation(invisibleF, "opacity", this);
        invizeFrame->setEndValue(0);
        invizeFrame->setDuration(1000);
        invizeFrame->start(invizeFrame->DeleteWhenStopped);

        //Все вместе не работает, поэтому пришлось сделать последовательно
//        QSequentialAnimationGroup* all = new QSequentialAnimationGroup(this);
//        all->addAnimation(line);
//        all->addAnimation(invizeFrame);
//        all->start(all->DeleteWhenStopped);

    }
    else
    {
        //Красный текст
        QPropertyAnimation* redText = new QPropertyAnimation(this, "color", this);
        redText->setStartValue("dark red");
        redText->setEndValue(ui->loginLine->styleSheet());
        redText->setDuration(400);

        //Движение
        QPropertyAnimation* moveL = new QPropertyAnimation(ui->frame, "geometry", this);
        moveL->setDuration(100);
        moveL->setEndValue(QRect(ui->frame->x() - 10,ui->frame->y(), ui->frame->width(), ui->frame->height()));
        QPropertyAnimation* moveR = new QPropertyAnimation(ui->frame, "geometry", this);
        moveR->setDuration(100);
        moveR->setEndValue(QRect(ui->frame->x() + 10,ui->frame->y(), ui->frame->width(), ui->frame->height()));
        QPropertyAnimation* moveB = new QPropertyAnimation(ui->frame, "geometry", this);
        moveB->setDuration(100);
        moveB->setEndValue(QRect(ui->frame->x() ,ui->frame->y(), ui->frame->width(), ui->frame->height()));
        QSequentialAnimationGroup* move = new QSequentialAnimationGroup(this);
        move->addAnimation(moveL);
        move->addAnimation(moveR);
        move->addAnimation(moveB);

        //Парралельная анимация
        QParallelAnimationGroup* fail = new QParallelAnimationGroup(this);
        fail->addAnimation(redText);
        fail->addAnimation(move);
        fail->start(fail->DeleteWhenStopped);
    }
}

