import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Window {
    id:root
    visible: true
    width: 640
    height: 500
    title: qsTr("Geron")
    color: "#778899"

    property real p: 0
    property real s: 0

    property real aB: 0
    property real bC: 0
    property real aC: 0

    function geron() {
        if (a.text*1 !== 0 && b.text*1 !== 0 && c.text*1 !== 0) {
            p = (a.text*1 + b.text*1 + c.text*1) / 2
            s = Math.sqrt(p*(p-a.text*1)*(p-b.text*1)*(p-c.text*1))
            if(s)
            {
                anim1.start()
                result.text = s.toString()
            if (textArea.opacity === 0)
                animationStart.start()
            else
                animationNewValue.start()
            }
            else
            {
                if (textArea.opacity === 0)
                    errorText.start()
                else
                    failNan.start()
            }
        }
        else
            fail.start()
    }

    function points() {
        if(ax.text !== "" && ay.text !== "" &&
                bx.text !== "" && by.text !== "" &&
                cx.text !== "" && cy.text !== "")
        {
            aB = Math.sqrt(Math.pow(bx.text*1 - ax.text*1, 2) + Math.pow(by.text*1 - ay.text*1,2))
            a.text = aB
            aC = Math.sqrt(Math.pow(cx.text*1 - ax.text*1, 2) + Math.pow(cy.text*1 - ay.text*1,2))
            c.text = aC
            bC = Math.sqrt(Math.pow(cx.text*1 - bx.text*1, 2) + Math.pow(cy.text*1 - by.text*1,2))
            b.text = bC
            p = (aB + bC + aC) / 2
            s = Math.abs(Math.sqrt(p*(p-aB)*(p-aC)*(p-bC)))
            console.log(s)
            anim1.start()
            result1.text = s.toString()
            if (textArea1.opacity === 0)
                animationStartP.start()
            else
                animationNewValueP.start()
        }
        else
        {
            failP.start()
        }
    }


    Rectangle {
        id: textRec
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        height: parent.height
        width: parent.width / 4
        color: "#708090"
        property string lineColor: "#2f4f4f"
        property string backroundColor: "#778899"
        property string focusLine: "#00ced1"
        property string hoveredItem: "#20b2aa"
        property string placeholderTextCol: "#2f4f4f"
        property string boarderColorItem: "#48d1cc"
        property int radiusItem: 10

        SwipeView {
            id:view
            clip: true
            currentIndex: 0
            anchors.fill: parent

            Item {
                id: pade1

                Column {
                    id: col
                    anchors.fill: parent
                    padding: 20
                    spacing: 10
                    activeFocusOnTab : true
                    clip: true

                    Label {
                        id:textEnter
                        text: "Вычисления площади треугольника с помощью формулы Герона по известным трем сторонам"
                        color: textRec.placeholderTextCol
                        width: parent.width
                        anchors.horizontalCenter: parent.horizontalCenter
                        horizontalAlignment: Text.AlignHCenter
                        wrapMode: Text.WordWrap
                    }

                    TextField {
                        id: a
                        placeholderText: qsTr("A")
                        anchors.horizontalCenter: parent.horizontalCenter
                        color: textRec.lineColor
                        height: parent.height / 10
                        width: parent.width / 2
                        maximumLength: 7
                        placeholderTextColor: textRec.placeholderTextCol
                        validator: RegularExpressionValidator{
                           regularExpression: /\d{1,9}.{1,9}/
                        }
                        background: Rectangle {
                            id:backa
                            radius: textRec.radiusItem
                            border.color: textRec.boarderColorItem
                            color: parent.focus ? textRec.focusLine :
                                                  parent.hovered ? textRec.hoveredItem : textRec.backroundColor
                        }
                    }

                    TextField {
                        id: b
                        placeholderText: qsTr("B")
                        anchors.horizontalCenter: parent.horizontalCenter
                        color: textRec.lineColor
                        height: parent.height / 10
                        width: parent.width / 2
                        maximumLength: 7
                        validator: RegularExpressionValidator{
                           regularExpression: /\d{1,9}.{1,9}/
                        }
                        placeholderTextColor: textRec.placeholderTextCol
                        background: Rectangle {
                            id:backb
                            border.color: textRec.boarderColorItem
                            radius: textRec.radiusItem
                            color: parent.focus ? textRec.focusLine :
                                                  parent.hovered ? textRec.hoveredItem : textRec.backroundColor
                        }
                    }

                    TextField {

                        id: c
                        placeholderText: qsTr("C")
                        anchors.horizontalCenter: parent.horizontalCenter
                        color: textRec.lineColor
                        height: parent.height / 10
                        width: parent.width / 2
                        validator: RegularExpressionValidator{
                           regularExpression: /\d{1,9}.{1,9}/
                        }
                        maximumLength: 7
                        placeholderTextColor: textRec.placeholderTextCol
                        background: Rectangle {
                            id:backc
                            border.color: textRec.boarderColorItem
                            radius: textRec.radiusItem
                            color: parent.focus ? textRec.focusLine :
                                                  parent.hovered ? textRec.hoveredItem : textRec.backroundColor
                        }
                    }

                    Button {
                        id: butGer
                        anchors.horizontalCenter: parent.horizontalCenter
                        height: parent.height / 10
                        width: parent.width / 2
                        text: "Go"
                        onClicked: geron()
                        contentItem: Text{
                            anchors.fill: parent
                            text: parent.text
                            font: parent.font
                            color: textRec.lineColor
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }

                        background: Rectangle {
                            radius: textRec.radiusItem
                            border.color: textRec.boarderColorItem
                            color: parent.down ? textRec.focusLine :
                                                 (parent.hovered ? textRec.hoveredItem : textRec.backroundColor)
                        }

                    }

                    Label {
                        id:textArea
                        text: "Ответ"
                        color: textRec.placeholderTextCol
                        anchors.horizontalCenter: parent.horizontalCenter
                        opacity: 0
                        horizontalAlignment: Text.AlignHCenter
                        width: parent.width
                        wrapMode: Text.WordWrap
                    }

                    TextField {
                        id: result
                        placeholderText: qsTr("Ответ")
                        anchors.horizontalCenter: parent.horizontalCenter
                        enabled: false
                        color: textRec.lineColor
                        height: parent.height / 10
                        width: parent.width / 2
                        opacity: 0
                        placeholderTextColor: textRec.placeholderTextCol
                        maximumLength: 7
                        background: Rectangle {
                            id: backr
                            border.color: textRec.boarderColorItem
                            radius: textRec.radiusItem
                            color: parent.focus ? textRec.focusLine :
                                                  parent.hovered ? textRec.hoveredItem : textRec.backroundColor
                        }
                    }

                }
            }

            Item {
                id: page2
                Column {
                    id: colP
                    anchors.fill: parent
                    padding: 20
                    spacing: 10
                    activeFocusOnTab : true
                    clip: true

                    Label {
                        id:textEnterP
                        text: "Вычисления площади треугольника по координатам вершин треугольника"
                        color: textRec.placeholderTextCol
                        width: parent.width
                        anchors.horizontalCenter: parent.horizontalCenter
                        horizontalAlignment: Text.AlignHCenter
                        wrapMode: Text.WordWrap
                    }

                    Row {
                        id: rowa
                        anchors.horizontalCenter: colP.horizontalCenter
                        spacing: 10
                        TextField {
                            id: ax
                            placeholderText: qsTr("A {x}")
                            color: textRec.lineColor
                            height: colP.height / 10
                            width: colP.width / 4
                            maximumLength: 7
                            placeholderTextColor: textRec.placeholderTextCol
                            validator: IntValidator{
                               bottom: -500
                               top: 500
                            }
                            background: Rectangle {
                                id:backax
                                radius: textRec.radiusItem
                                border.color: textRec.boarderColorItem
                                color: parent.focus ? textRec.focusLine :
                                                      parent.hovered ? textRec.hoveredItem : textRec.backroundColor
                            }
                        }
                        TextField {
                            id: ay
                            placeholderText: qsTr("A {y}")
                            color: textRec.lineColor
                            height: colP.height / 10
                            width: colP.width / 4
                            maximumLength: 7
                            placeholderTextColor: textRec.placeholderTextCol
                            validator: IntValidator{
                               bottom: -500
                               top: 500
                            }
                            background: Rectangle {
                                id:backay
                                radius: textRec.radiusItem
                                border.color: textRec.boarderColorItem
                                color: parent.focus ? textRec.focusLine :
                                                      parent.hovered ? textRec.hoveredItem : textRec.backroundColor
                            }
                        }
                    }

                    Row {
                        id: rowb
                        anchors.horizontalCenter: colP.horizontalCenter
                        spacing: 10
                        TextField {
                            id: bx
                            placeholderText: qsTr("B {x}")
                            color: textRec.lineColor
                            height: colP.height / 10
                            width: colP.width / 4
                            maximumLength: 7
                            placeholderTextColor: textRec.placeholderTextCol
                            validator: IntValidator{
                               bottom: -500
                               top: 500
                            }
                            background: Rectangle {
                                id:backbx
                                radius: textRec.radiusItem
                                border.color: textRec.boarderColorItem
                                color: parent.focus ? textRec.focusLine :
                                                      parent.hovered ? textRec.hoveredItem : textRec.backroundColor
                            }
                        }
                        TextField {
                            id: by
                            placeholderText: qsTr("B {y}")
                            color: textRec.lineColor
                            height: colP.height / 10
                            width: colP.width / 4
                            maximumLength: 7
                            placeholderTextColor: textRec.placeholderTextCol
                            validator: IntValidator{
                               bottom: -500
                               top: 500
                            }
                            background: Rectangle {
                                id:backby
                                radius: textRec.radiusItem
                                border.color: textRec.boarderColorItem
                                color: parent.focus ? textRec.focusLine :
                                                      parent.hovered ? textRec.hoveredItem : textRec.backroundColor
                            }
                        }
                    }

                    Row {
                        id: rowc
                        anchors.horizontalCenter: colP.horizontalCenter
                        spacing: 10
                        TextField {
                            id: cx
                            placeholderText: qsTr("C {x}")
                            color: textRec.lineColor
                            height: colP.height / 10
                            width: colP.width / 4
                            maximumLength: 7
                            placeholderTextColor: textRec.placeholderTextCol
                            validator: IntValidator{
                               bottom: -500
                               top: 500
                            }
                            background: Rectangle {
                                id:backcx
                                radius: textRec.radiusItem
                                border.color: textRec.boarderColorItem
                                color: parent.focus ? textRec.focusLine :
                                                      parent.hovered ? textRec.hoveredItem : textRec.backroundColor
                            }
                        }
                        TextField {
                            id: cy
                            placeholderText: qsTr("C {y}")
                            color: textRec.lineColor
                            height: colP.height / 10
                            width: colP.width / 4
                            maximumLength: 7
                            placeholderTextColor: textRec.placeholderTextCol
                            validator: IntValidator{
                               bottom: -500
                               top: 500
                            }
                            background: Rectangle {
                                id:backcy
                                radius: textRec.radiusItem
                                border.color: textRec.boarderColorItem
                                color: parent.focus ? textRec.focusLine :
                                                      parent.hovered ? textRec.hoveredItem : textRec.backroundColor
                            }
                        }
                    }

                    Button {
                        id: butGer1
                        anchors.horizontalCenter: parent.horizontalCenter
                        height: parent.height / 10
                        width: parent.width / 2
                        text: "Go"
                        onClicked: points()
                        contentItem: Text{
                            anchors.fill: parent
                            text: parent.text
                            font: parent.font
                            color: textRec.lineColor
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }

                        background: Rectangle {
                            radius: textRec.radiusItem
                            border.color: textRec.boarderColorItem
                            color: parent.down ? textRec.focusLine :
                                                 (parent.hovered ? textRec.hoveredItem : textRec.backroundColor)
                        }

                    }

                    Label {
                        id:textArea1
                        text: "Ответ"
                        color: textRec.placeholderTextCol
                        anchors.horizontalCenter: parent.horizontalCenter
                        opacity: 0
                        horizontalAlignment: Text.AlignHCenter
                        width: parent.width
                        wrapMode: Text.WordWrap
                    }

                    TextField {
                        id: result1
                        placeholderText: qsTr("Ответ")
                        anchors.horizontalCenter: parent.horizontalCenter
                        enabled: false
                        color: textRec.lineColor
                        height: parent.height / 10
                        width: parent.width / 2
                        opacity: 0
                        placeholderTextColor: textRec.placeholderTextCol
                        maximumLength: 7
                        background: Rectangle {
                            id: backr1
                            border.color: textRec.boarderColorItem
                            radius: textRec.radiusItem
                            color: parent.focus ? textRec.focusLine :
                                                  parent.hovered ? textRec.hoveredItem : textRec.backroundColor
                        }
                    }

                }
            }
        }

    }

    Rectangle {
        id: butRow
        height: 50
        width: parent.width / 4
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.rrght
        color: textRec.boarderColorItem
        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            padding: 10
            spacing: 10
            Button {
                id: butGerP
                height: col.height / 20
                width: col.width / 3
                text: "Geron"
                        onClicked: view.currentIndex = 0
                contentItem: Text{
                    anchors.fill: parent
                    text: parent.text
                    font: parent.font
                    color: textRec.lineColor
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                background: Rectangle {
                    radius: textRec.radiusItem
                    border.color: textRec.boarderColorItem
                    color: parent.down ? textRec.focusLine :
                                         (parent.hovered ? textRec.hoveredItem : textRec.backroundColor)
                }
            }
                Button {
                    id: butGerL
                    height: col.height / 20
                    width: col.width / 3
                    text: "Point"
                            onClicked: view.currentIndex = 1
                    contentItem: Text{
                        anchors.fill: parent
                        text: parent.text
                        font: parent.font
                        color: textRec.lineColor
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    background: Rectangle {
                        radius: textRec.radiusItem
                        border.color: textRec.boarderColorItem
                        color: parent.down ? textRec.focusLine :
                                             (parent.hovered ? textRec.hoveredItem : textRec.backroundColor)
                    }
                }
        }
    }

    PropertyAnimation {
        id:animationStart
        targets: [textArea, result]
        property: "opacity"
        to: 1
        duration: 500
    }

    PropertyAnimation {
        id:animationStartP
        targets: [textArea1, result1]
        property: "opacity"
        to: 1
        duration: 500
    }

    ParallelAnimation {
        id:animationNewValue

        SequentialAnimation {

            PropertyAnimation {
                targets: backr
                property: "color"
                to: textRec.hoveredItem
                duration: 0
            }
            PropertyAnimation {
                targets: backr
                property: "color"
                to: textRec.backroundColor
                duration: 400
            }
        }

        SequentialAnimation {

            NumberAnimation {
                targets: [textArea, result]
                property: "anchors.horizontalCenterOffset"
                to: -10
                duration: 50
            }
            NumberAnimation {
                targets: [textArea, result]
                property: "anchors.horizontalCenterOffset"
                to: 10
                duration: 100
            }
            NumberAnimation {
                targets: [textArea, result]
                property: "anchors.horizontalCenterOffset"
                to: 0
                duration: 50
            }
        }
    }

    ParallelAnimation {
        id:animationNewValueP

        SequentialAnimation {

            PropertyAnimation {
                targets: backr1
                property: "color"
                to: textRec.hoveredItem
                duration: 0
            }
            PropertyAnimation {
                targets: backr1
                property: "color"
                to: textRec.backroundColor
                duration: 400
            }
        }

        SequentialAnimation {

            NumberAnimation {
                targets: [textArea1, result1]
                property: "anchors.horizontalCenterOffset"
                to: -10
                duration: 50
            }
            NumberAnimation {
                targets: [textArea1, result1]
                property: "anchors.horizontalCenterOffset"
                to: 10
                duration: 100
            }
            NumberAnimation {
                targets: [textArea1, result1]
                property: "anchors.horizontalCenterOffset"
                to: 0
                duration: 50
            }
        }
    }

    ParallelAnimation {
        id: fail

        SequentialAnimation {

            PropertyAnimation {
                targets: [a.text*1 != 0 ? "" : backa,
                    b.text*1 != 0 ? "" : backb,
                    c.text*1 != 0 ? "" : backc]
                property: "color"
                to: "dark red"
                duration: 0
            }
            PropertyAnimation {
                targets: [a.text*1 != 0 ? "" : backa,
                    b.text*1 != 0 ? "" : backb,
                    c.text*1 != 0 ? "" : backc]
                property: "color"
                to: textRec.backroundColor
                duration: 400
            }
        }

        SequentialAnimation {

            NumberAnimation {
                targets: [a.text*1 != 0 ? "" : a,
                    b.text*1 != 0 ? "" : b,
                    c.text*1 != 0 ? "" : c]
                property: "anchors.horizontalCenterOffset"
                to: -10
                duration: 50
            }
            NumberAnimation {
                targets: [a.text*1 != 0 ? "" : a,
                    b.text*1 != 0 ? "" : b,
                    c.text*1 != 0 ? "" : c]
                property: "anchors.horizontalCenterOffset"
                to: 10
                duration: 100
            }
            NumberAnimation {
                targets: [a.text*1 != 0 ? "" : a,
                    b.text*1 != 0 ? "" : b,
                    c.text*1 != 0 ? "" : c]
                property: "anchors.horizontalCenterOffset"
                to: 0
                duration: 50
            }
        }
        SequentialAnimation {

            PropertyAnimation {
                target: textArea
                properties: "text"
                to: "Введите корректные значения"
                duration: 400
            }

            PropertyAnimation {
                target: textArea
                properties: "opacity"
                to: 1
                duration: 500
            }

            PropertyAnimation {
                target: textArea
                properties: "opacity"
                to: 0
                duration: 500
            }

            PropertyAnimation {
                target: textArea
                properties: "text"
                to: "Ответ"
                duration: 0
            }
        }
    }

    ParallelAnimation {
        id: failP

        SequentialAnimation {

            PropertyAnimation {
                targets: [ax.text !== "" ? "" : backax,
                    ay.text !== "" ? "" : backay,
                    bx.text !== "" ? "" : backbx,
                    by.text !== "" ? "" : backby,
                    cx.text !== "" ? "" : backcx,
                    cy.text !== "" ? "" : backcy]
                property: "color"
                to: "dark red"
                duration: 0
            }
            PropertyAnimation {
                targets: [ax.text !== "" ? "" : backax,
                    ay.text !== "" ? "" : backay,
                    bx.text !== "" ? "" : backbx,
                    by.text !== "" ? "" : backby,
                    cx.text !== "" ? "" : backcx,
                    cy.text !== "" ? "" : backcy]
                property: "color"
                to: textRec.backroundColor
                duration: 400
            }
        }

        SequentialAnimation {

            NumberAnimation {
                targets: [ax.text !== "" ? "" : rowa,
                    ay.text !== "" ? "" : rowa,
                    bx.text !== "" ? "" : rowb,
                    by.text !== "" ? "" : rowb,
                    cx.text !== "" ? "" : rowc,
                    cy.text !== "" ? "" : rowc]
                property: "anchors.horizontalCenterOffset"
                to: -10
                duration: 50
            }
            NumberAnimation {
                targets: [ax.text !== "" ? "" : rowa,
                    ay.text !== "" ? "" : rowa,
                    bx.text !== "" ? "" : rowb,
                    by.text !== "" ? "" : rowb,
                    cx.text !== "" ? "" : rowc,
                    cy.text !== "" ? "" : rowc]
                property: "anchors.horizontalCenterOffset"
                to: 10
                duration: 100
            }
            NumberAnimation {
                targets: [ax.text !== "" ? "" : rowa,
                    ay.text !== "" ? "" : rowa,
                    bx.text !== "" ? "" : rowb,
                    by.text !== "" ? "" : rowb,
                    cx.text !== "" ? "" : rowc,
                    cy.text !== "" ? "" : rowc]
                property: "anchors.horizontalCenterOffset"
                to: 0
                duration: 50
            }
        }
        SequentialAnimation {

            PropertyAnimation {
                target: textArea1
                properties: "text"
                to: "Введите корректные значения"
                duration: 400
            }

            PropertyAnimation {
                target: textArea1
                properties: "opacity"
                to: 1
                duration: 500
            }

            PropertyAnimation {
                target: textArea1
                properties: "opacity"
                to: 0
                duration: 500
            }

            PropertyAnimation {
                target: textArea1
                properties: "text"
                to: "Ответ"
                duration: 0
            }
        }
    }

    ParallelAnimation {
        id: failNan

        SequentialAnimation {

            PropertyAnimation {
                targets: [backr]
                property: "color"
                to: "dark red"
                duration: 0
            }
            PropertyAnimation {
                targets: [backr]
                property: "color"
                to: textRec.backroundColor
                duration: 400
            }
        }

        SequentialAnimation {

            NumberAnimation {
                targets: [textArea, result]
                property: "anchors.horizontalCenterOffset"
                to: -10
                duration: 50
            }
            NumberAnimation {
                targets: [textArea, result]
                property: "anchors.horizontalCenterOffset"
                to: 10
                duration: 100
            }
            NumberAnimation {
                targets: [textArea, result]
                property: "anchors.horizontalCenterOffset"
                to: 0
                duration: 50
            }
        }
    }

    SequentialAnimation {
        id: errorText

        PropertyAnimation {
            target: textArea
            properties: "text"
            to: "Невычислямое значение"
            duration: 500
        }

        PropertyAnimation {
            target: textArea
            properties: "opacity"
            to: 1
            duration: 1000
        }

        PropertyAnimation {
            target: textArea
            properties: "opacity"
            to: 0
            duration: 1000
        }

        PropertyAnimation {
            target: textArea
            properties: "text"
            to: "Ответ"
            duration: 0
        }
    }

    Rectangle {
        id: workFrame
        anchors.left: textRec.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: 20
        color: "transparent"
        property int sizex: parent.width
        property int sizey: parent.height
        Rectangle {
            id: support
            height: parent.height
            width: parent.width
            color: "transparent"
            border.color: "#48d1cc"
            radius: 5
            clip: true
            Canvas {
                id: tr
                anchors.margins: 20
                anchors.fill: parent
                visible: false
                property real xPoint: parent.width / 3
                property real yPoint: parent.width / 3
                onPaint: {
                    let A = 1 * a.text,
                        B = 1 * b.text,
                        C = 1 * c.text;
                    let SinA = 2 * s / (A * B);
                    let alpha = Math.asin(SinA);

                    let x = B * Math.cos(alpha),
                        y = B * Math.sin(alpha);

                    var ctx = getContext("2d");

                    ctx.reset()
                    ctx.beginPath();
                    ctx.moveTo(tr.xPoint + A * 30, tr.yPoint);
                    ctx.lineTo(tr.xPoint, tr.yPoint);
                    ctx.lineTo(tr.xPoint + x * 30, tr.yPoint - y * 30);
                    ctx.lineTo(tr.xPoint + A * 30, tr.yPoint);
                    ctx.stroke();
                }
                WheelHandler {
                    property: "rotation"
                    onWheel: {
                        var ctx = getContext("2d");
                        ctx.reset()
                        ctx.beginPath();
                        ctx.moveTo(tr.xPoint - 1 + A * 30, tr.yPoint - 1);
                        ctx.lineTo(tr.xPoint - 1, tr.yPoint - 1);
                        ctx.lineTo(tr.xPoint - 1 + x * 30, tr.yPoint - y * 30 - 1);
                        ctx.lineTo(tr.xPoint - 1 + A * 30, tr.yPoint - 1);
                        ctx.stroke();
                    }
                }
            }
        }
    }

    PropertyAnimation {
        id: anim1
        target: support
        properties: "height"
        to: 0
        duration: 500
        onStarted: { tr.visible = false }
        onFinished: {
            tr.visible = true
            tr.requestPaint()
            anim2.start()
        }
    }
    PropertyAnimation {
        id: anim2
        target: support
        properties: "height"
        to: workFrame.sizey - 40
        duration: 500
    }

}
