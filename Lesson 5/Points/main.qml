import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import "FunctionPoints.js" as FP
Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    Item {
        anchors.fill: parent
        Canvas {
            id: canvas
            anchors.fill: parent
            property string selectedSHape: "star"
            property var posHor: canvas.width / 2
            property var posVer: canvas.height / 2
            property var firstV: 20
            property var secondV: 50
            property var thirdV: 5
            property var points: 0
            onPaint: {
                var ctx = getContext("2d")
                ctx.clearRect(0, 0, width, height)
                switch(canvas.selectedSHape) {
                case "star":
                    var points = FP.getStarPoints(posHor, posVer, firstV, secondV, thirdV)
                    break
                case "ring":
                    points = FP.getRingPoints(posHor, posVer, firstV, secondV)
                    break
                case "house":
                    points = FP.getHousePoints(posHor, posVer, firstV, secondV)
                    break
                case "hourglass":
                    points = FP.getHourglassPoints(posHor, posVer, firstV, secondV)
                    break
                }
                ctx.beginPath()
                ctx.moveTo(points[0], points[1])
                for (var i = 0; i < points.length; i+= 2) {
                    ctx.lineTo(points[i], points[i + 1])
                }
                ctx.closePath()
                ctx.stroke()
            }
        }
        Column {
            id:col
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: 100
            state: "star"
            states: [
                State {
                    name: "star"
                    PropertyChanges {target: firstValueLabel; text: "Outer Radius"}
                    PropertyChanges {target: secondValueLabel; text: "Inner Radius"}
                    PropertyChanges {target: thirdValueLabel; text: "Angle"}
                    PropertyChanges {target: thirdValueLabel; opacity: 1}
                    PropertyChanges {target: thirdValue; opacity: 1}
                    PropertyChanges {target: thirdValue; enabled: true}
                },
                State {
                    name: "ring"
                    PropertyChanges {target: firstValueLabel; text: "Radius"}
                    PropertyChanges {target: secondValueLabel; text: "Thickness"}
                    PropertyChanges {target: thirdValueLabel; opacity: 0}
                    PropertyChanges {target: thirdValue; opacity: 0}
                    PropertyChanges {target: thirdValue; enabled: false}
                },
                State {
                    name: "house"
                    PropertyChanges {target: firstValueLabel; text: "Width"}
                    PropertyChanges {target: secondValueLabel; text: "Height"}
                    PropertyChanges {target: thirdValueLabel; opacity: 0}
                    PropertyChanges {target: thirdValue; opacity: 0}
                    PropertyChanges {target: thirdValue; enabled: false}
                },
                State {
                    name: "hourglass"
                    PropertyChanges {target: firstValueLabel; text: "Width"}
                    PropertyChanges {target: secondValueLabel; text: "Height"}
                    PropertyChanges {target: thirdValueLabel; opacity: 0}
                    PropertyChanges {target: thirdValue; opacity: 0}
                    PropertyChanges {target: thirdValue; enabled: false}
                }
            ]
            transitions: [
                Transition {
                    to: "star"
                    ParallelAnimation {
                        PropertyAnimation {target: thirdValueLabel; property: "opacity"; duration: 200}
                        PropertyAnimation {target: firstValueLabel; property: "text"; duration: 200}
                        PropertyAnimation {target: secondValueLabel; property: "text"; duration: 200}
                        PropertyAnimation {target: thirdValueLabel; property: "text"; duration: 200}
                    }
                },
                Transition {
                    to: "ring"
                    ParallelAnimation {
                        PropertyAnimation {target: thirdValueLabel; property: "opacity"; duration: 200}
                        PropertyAnimation {target: firstValueLabel; property: "text"; duration: 200}
                        PropertyAnimation {target: secondValueLabel; property: "text"; duration: 200}
                        PropertyAnimation {target: thirdValueLabel; property: "text"; duration: 200}
                    }
                },
                Transition {
                    to: "house"
                    ParallelAnimation {
                        PropertyAnimation {target: thirdValueLabel; property: "opacity"; duration: 200}
                        PropertyAnimation {target: thirdValueLabel; property: "text"; duration: 200}
                        PropertyAnimation {target: firstValueLabel; property: "text"; duration: 200}
                        PropertyAnimation {target: secondValueLabel; property: "text"; duration: 200}
                        PropertyAnimation {target: thirdValueLabel; property: "text"; duration: 200}
                    }
                },
                Transition {
                    to: "hourglass"
                    ParallelAnimation {
                        PropertyAnimation {target: thirdValueLabel; property: "opacity"; duration: 200}
                        PropertyAnimation {target: firstValueLabel; property: "text"; duration: 200}
                        PropertyAnimation {target: secondValueLabel; property: "text"; duration: 200}
                        PropertyAnimation {target: thirdValueLabel; property: "text"; duration: 200}
                    }
                }
            ]
            Label {text: "Position horizont";anchors.horizontalCenter: parent.horizontalCenter}
            Slider {
                id: posH
                from: 1
                to:canvas.width
                value: canvas.width / 2
                stepSize: 1
                onValueChanged: {canvas.posHor = posH.value; canvas.requestPaint()}
            }
            Label {text: "Position vertical";anchors.horizontalCenter: parent.horizontalCenter}
            Slider {
                id: posV
                from: 1
                to:canvas.height
                value: canvas.height / 2
                stepSize: 1
                onValueChanged: {canvas.posVer = posV.value; canvas.requestPaint()}
            }
            Label {id: firstValueLabel;text: "Outer Radius";anchors.horizontalCenter: parent.horizontalCenter}
            Slider {
                id: firstValue
                from: 1
                to:200
                value: 50
                stepSize: 1
                onValueChanged: {canvas.firstV = firstValue.value; canvas.requestPaint()}
            }
            Label {id: secondValueLabel;text: "Inner Radius";anchors.horizontalCenter: parent.horizontalCenter}
            Slider {
                id: secondValue
                from: 1
                to:200
                stepSize: 1
                value: 20
                onValueChanged: {canvas.secondV = secondValue.value; canvas.requestPaint()}
            }
            Label {id: thirdValueLabel;text: "Angle";anchors.horizontalCenter: parent.horizontalCenter}
            Slider {
                id: thirdValue
                from: 1
                to:200
                stepSize: 1
                value: 5
                onValueChanged: {canvas.thirdV = thirdValue.value; canvas.requestPaint()}
            }
        }
        ComboBox {
            id:comboBox
            anchors.horizontalCenter: parent.horizontalCenter
            model: ["star", "ring", "house", "hourglass"]
            currentIndex: 0
            onCurrentIndexChanged: {
                canvas.selectedSHape = model[currentIndex]
                col.state = model[currentIndex]
                canvas.requestPaint()
            }
        }
    }
}
