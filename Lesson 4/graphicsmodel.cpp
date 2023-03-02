#include "graphicsmodel.h"
#include <QtMath>

GraphicsModel::GraphicsModel(QObject *parent)
    : QObject(parent),
      m_color(Qt::blue),
      m_parameterName("x"),
      m_graphType(Sine)
{
    for (double x = 0; x <= 5; x+=0.1)
        m_xValues.append(x);
    updateYValues();
}

void GraphicsModel::setColor(const QColor &color)
{
    if (m_color != color)
    {
        m_color = color;
        emit colorChanged();
    }
}

void GraphicsModel::setParameterName(const QString &name)
{
    if (m_parameterName != name)
    {
        m_parameterName = name;
        emit parameterNameChanged();
    }
}

void GraphicsModel::setGraphType(GraphicsModel::GraphType graphType)
{
    if (m_graphType != graphType)
    {
        m_graphType = graphType;
        updateYValues();
        emit graphTypeChanged();
    }
}

void GraphicsModel::updateYValues()
{
    m_yValues.clear();
    switch (m_graphType)
    {
        case Sine:
            for (double x : m_xValues)
                m_yValues.append(qSin(x));
            break;
        case Linear:
            for (double x : m_xValues)
                m_yValues.append(x);
            break;
        case AbcoluteLine:
            for (double x : m_xValues)
                m_yValues.append(qAbs(x - 2.5));
            break;
        case Square:
            for (double x : m_xValues)
                m_yValues.append(qPow(x, 2));
            break;
        case Logarithm:
            for (double x : m_xValues)
                m_yValues.append(log2(x));
            break;
    }
}
