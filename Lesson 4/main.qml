import QtQuick 2.12
import QtQuick.Window 2.12
import QtCharts 2.3
import GraphicsModel 1.0
import QtQuick.Controls 2.12

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")
    StackView {
        id:stack
        initialItem: mainView
        anchors.fill: parent
        Page {
            id:mainView
            GraphicsModel {
                id: gr
                color: "red"
                parameterName: "y = sin(x)"
                graphType: chartView.numerationCharts
                onGraphTypeChanged: {
                    if (graphType == GraphicsModel.Sine)
                    {
                        gr.parameterName = "y = sin(x)"
                        gr.color = "red"
                        yVL.max = 2
                        yVL.min = -2
                    }
                    if (graphType == GraphicsModel.Linear)
                    {
                        gr.parameterName = "y = x"
                        gr.color = "green"
                        yVL.max = 5
                        yVL.min = 0
                    }
                    if (graphType == GraphicsModel.AbcoluteLine)
                    {
                        gr.parameterName = "y = |x - 2.5|"
                        gr.color = "blue"
                        yVL.max = 3
                        yVL.min = 0
                    }
                    if (graphType == GraphicsModel.Square)
                    {
                        gr.parameterName = "y = x * x"
                        gr.color = "black"
                        yVL.max = 25
                        yVL.min = 0
                    }
                    if (graphType == GraphicsModel.Logarithm)
                    {
                        gr.parameterName = "y = log2(x)"
                        gr.color = "brown"
                        yVL.max = 3
                        yVL.min = -5
                    }
                }
            }
            ChartView {
                id:chartView
                title: "Charts"
                anchors.fill: parent
                antialiasing: true
                margins.bottom: 50
                animationOptions: ChartView.AllAnimations
                property var numerationCharts: 0
                property bool flagSerais: true
                LineSeries {
                    id: line
                    name: gr.parameterName
                    color: gr.color
                    axisX: ValueAxis {
                        id:xVL
                        labelFormat: "%.0f"
                        min: 0
                        max: 5
                    }
                    axisY: ValueAxis {
                        id:yVL
                        labelFormat: "%.0f"
                        min: -5
                        max: 5
                    }
                    Component.onCompleted: {
                        var x = []
                        var y = []
                        for (var i = 0; i < 50; ++i) {
                            x = gr.xValues[i]
                            y = gr.yValues[i]
                            line.append(x,y)
                        }
                    }
                }
                //Очень долго мучился как сделать добавление всех графиков на одном LineSeries
                //Не получается, получилось вывести но это все одна линия и получается очень криво
                Button {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.margins: 10
                    text: "Следующий график"
                    height: 30
                    onClicked: {
                        if (chartView.numerationCharts > 3)
                        {
                            chartView.numerationCharts = 0
                            gr.graphType = chartView.numerationCharts
                        }
                        else
                        {
                            ++chartView.numerationCharts
                            gr.graphType = chartView.numerationCharts
                        }
                        line.clear()
                        var x = []
                        var y = []
                        for (var i = 0; i < 50; ++i) {
                            x = gr.xValues[i]
                            y = gr.yValues[i]
                            line.append(x,y)
                        }
                    }
                }
                Button {
                    anchors.bottom: parent.bottom
                    anchors.right: parent.right
                    anchors.margins: 10
                    text: "Метод наименьших квадратов"
                    height: 30
                    onClicked: {
                        stack.push(rec)
                    }
                }
            }
        }
        Page {
            id: rec
            ChartView {
                id: chart
                anchors.fill: parent
                margins.bottom: 50
                ValueAxis {
                    id: axisX
                    min: 0
                    max: 250
                    tickCount: 7
                    labelFormat: "%.0f"
                }
                ValueAxis {
                    id: axisY
                    min: 0
                    max: 30
                    tickCount: 6
                    labelFormat: "%.0f"
                }
                ScatterSeries {
                    id:scat
                    name: "Data Points"
                    markerSize: 10
                    color: "Blue"
                    XYPoint {x:7;y:13}
                    XYPoint {x:31;y:10}
                    XYPoint {x:61;y:9}
                    XYPoint {x:99;y:10}
                    XYPoint {x:129;y:12}
                    XYPoint {x:178;y:20}
                    XYPoint {x:209;y:26}
                    function sq(){
                        if (scat.count == 7)
                        {
                            var x_mean = (7+31+61+99+129+178+209)/7
                            var y_mean = (13+10+9+10+12+20+26)/7
                            var x_diff = 0
                            var y_diff = 0
                            var xy_diff = 0
                            var x_sq_diff = 0
                            for (var i = 0; i < scat.count; i++)
                            {
                                var point = scat.at(i)
                                x_diff += point.x - x_mean
                                y_diff += point.y - y_mean
                                xy_diff += (point.x - x_mean) * (point.y - y_mean)
                                x_sq_diff += (point.x - x_mean) * (point.x - x_mean)
                            }
                            var b = xy_diff / x_sq_diff
                            var a = y_mean - b * x_mean
                            var x_min = scat.at(0).x
                            var x_max = scat.at(scat.count - 1).x
                            console.log("x_mean",x_mean)
                            console.log("y_mean",y_mean)
                            console.log("x_diff",x_diff)
                            console.log("y_diff",y_diff)
                            console.log("xy_diff",xy_diff)
                            console.log("x_sq_diff",x_sq_diff)
                            console.log("a",a)
                            console.log("b",b)
                            console.log("x_min",x_min)
                            console.log("x_max",x_max)
                            lineQ.clear()
                            lineQ.append(x_min, a+b*x_min)
                            lineQ.append(x_max, a+b*x_max)
                            label.text = "Коэффициенты линейной регресси: A = "
                            label.text += a.toFixed(3)
                            label.text += ", B = " + b.toFixed(3) + "\nЭто значит, что линейная зависимость примет вид:"
                            label.text += " " + "Y = " + b.toFixed(3) + "X + " + a.toFixed(3)
                        }
                    }
                }
                LineSeries {
                    id:lineQ
                    name: "Linear regression"
                    color: "red"
                }
                Component.onCompleted: scat.sq()
                Button {
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.margins: 10
                    text: "Назад"
                    height: 30
                    onClicked: {
                        stack.pop(mainView)
                    }
                }
                Label {
                    id:label
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.margins: 10
                    height: 30
                }
            }
        }
    }
}

