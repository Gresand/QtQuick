#ifndef GRAPHICSMODEL_H
#define GRAPHICSMODEL_H

#include <QObject>
#include <QString>
#include <QVector>
#include <QColor>

class GraphicsModel : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QColor color READ color WRITE setColor NOTIFY colorChanged)
    Q_PROPERTY(QString parameterName READ parameterName WRITE setParameterName NOTIFY parameterNameChanged)
    Q_PROPERTY(GraphType graphType READ graphType WRITE setGraphType NOTIFY graphTypeChanged)
    Q_PROPERTY(QVector<double> xValues READ xValues CONSTANT)
    Q_PROPERTY(QVector<double> yValues READ yValues NOTIFY yValuesChanged)
public:
    explicit GraphicsModel(QObject *parent = nullptr);

    enum GraphType
    {
        Sine = 0,
        Linear = 1,
        AbcoluteLine = 2,
        Square = 3,
        Logarithm = 4
    };
    Q_ENUMS(GraphType)

    inline QColor color() const {return m_color;}
    void setColor(const QColor &color);

    inline QString parameterName() const {return m_parameterName;}
    void setParameterName(const QString &name);

    inline GraphType graphType() const {return m_graphType;}
    void setGraphType(GraphType graphType);

    inline QVector<double> xValues() const {return m_xValues;}
    inline QVector<double> yValues() const {return m_yValues;}

signals:
    void colorChanged();
    void parameterNameChanged();
    void graphTypeChanged();
    void yValuesChanged();

public slots:

private:
    QColor m_color;
    QString m_parameterName;
    GraphType m_graphType;
    QVector<double> m_xValues;
    QVector<double> m_yValues;

    void updateYValues();
};

#endif // GRAPHICSMODEL_H
