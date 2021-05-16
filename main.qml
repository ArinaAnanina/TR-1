import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls.Material 2.4
import QtQuick.Controls 2.3
import calculator 1.0

Window {
    id: window
    width: 340
    height: 480
    visible: true
    title: qsTr("Calc")
    flags: Qt.FramelessWindowHint | Qt.Window
    Material.theme: Material.Dark
    Material.accent: "#78a9fe"
    property var primaryColor: "#2b7bff" //цвет не изменяемых текстов
    property var maxHistoryLength: 4
    property var historyItems: []
    property var onHistoryItemClicked: (index) => { //запускается при нажатии на элемент истории
        if (historyItems.length <= index) {
           return;
        }
        const data = window.historyItems[index].data;
        const textFileds = [textA11, textA12, textA13, textB1, textA21, textA22, textA23, textB2, textA31, textA32, textA33, textB3];
        data.forEach((item, ind) => { //заполнение ячеек коэффициентов на экране
            textFileds[ind].text = item;
            textFileds[ind].onTextEdited();
        });
        calculator.doCalculate();
    }
    property var onHistoryButtonClicked: (index) => {//выполняется при нажатии на кнопку 'история'
        sidebar.state = "opened"
    }
    // BACKGROUND
    Image {
        id: backgroundImage
        source: "bg.png"
        opacity: 1
    }

    Image {
        id: bracket
        x: 32
        y: 76
        source: "bracket.png"
        opacity: 1
    }


    Calculator { //получение 3 ответов из класса и вывод на экран
        id: calculator
        onAnswerReady: {
            answer1.text = ans1;
            answer2.text = ans2;
            answer3.text = ans3;
        }
    }


    Button {
        id: openHistoryButton
        x: 65
        y: 257
        width: 109
        height: 34
        text: qsTr("История")
        autoRepeat: false
        checkable: false
        checked: false
        autoExclusive: false
        display: AbstractButton.TextOnly
        onClicked: {
            window.onHistoryButtonClicked()
        }
    }

    Button {
        id: button
        x: 184
        y: 257
        width: 109
        height: 34
        text: qsTr("Вычислить")
        autoRepeat: false
        checkable: false
        checked: false
        autoExclusive: false
        display: AbstractButton.TextOnly
        onClicked: {
            calculator.doCalculate();
            const date = new Date();
            const name = date.getHours() + ':' + date.getMinutes() + ':' + date.getSeconds();
            const data = [+textA11.text, +textA12.text,+textA13.text, +textB1.text,
                           +textA21.text, +textA22.text,+textA23.text, +textB2.text,
                           +textA31.text, +textA32.text,+textA33.text, +textB3.text];
            const item = { name, data };
            historyItems.push(item);

            if (historyItems.length > window.maxHistoryLength) {
                historyItems.shift();
            }
            listView.model = window.historyItems.length;
        }
    }

    TextField {
        id: textA11
        x: 67
        y: 87
        width: 30
        height: 40
        text: qsTr("0")
        horizontalAlignment: Text.AlignRight
        font.pointSize: 10
        onTextEdited: {
            calculator.addValue(1, 1, text);
        }
    }

    TextField {
        id: textA12
        x: 133
        y: 87
        width: 30
        height: 40
        text: qsTr("0")
        horizontalAlignment: Text.AlignRight
        font.pointSize: 10
        onTextEdited: {
            calculator.addValue(1, 2, text);
        }
    }

    Text {
        id: text1
        x: 101
        y: 94
        width: 30
        height: 20
        color: window.primaryColor
        text: qsTr("X₁ +")
        font.pixelSize: 13
        font.bold: true
    }

    Text {
        id: text2
        x: 167
        y: 95
        width: 30
        height: 20
        color: window.primaryColor
        text: qsTr("X₂ +")
        font.pixelSize: 13
        font.bold: true
    }

    Text {
        id: text4
        x: 232
        y: 95
        width: 30
        height: 20
        color: window.primaryColor
        text: qsTr("X₃ =")
        font.pixelSize: 13
        font.bold: true
    }

    TextField {
        id: textA13
        x: 198
        y: 87
        width: 30
        height: 40
        text: qsTr("0")
        horizontalAlignment: Text.AlignRight
        font.pointSize: 10
        onTextEdited :{
            calculator.addValue(1, 3, text);
        }
    }

    TextField {
        id: textB1
        x: 263
        y: 87
        width: 30
        height: 40
        text: qsTr("0")
        horizontalAlignment: Text.AlignRight
        font.pointSize: 10
        onTextEdited: {
            calculator.addValue(1, 4, text);
        }
    }

    TextField {
        id: textA21
        x: 67
        y: 142
        width: 30
        height: 40
        text: qsTr("0")
        horizontalAlignment: Text.AlignRight
        font.pointSize: 10
        onTextEdited: {
            calculator.addValue(2, 1, text);
        }
    }

    TextField {
        id: textA22
        x: 133
        y: 142
        width: 30
        height: 40
        text: qsTr("0")
        horizontalAlignment: Text.AlignRight
        font.pointSize: 10
        onTextEdited: {
            calculator.addValue(2, 2, text);
        }
    }

    TextField {
        id: textA23
        x: 198
        y: 142
        width: 30
        height: 40
        text: qsTr("0")
        horizontalAlignment: Text.AlignRight
        font.pointSize: 10
        onTextEdited: {
            calculator.addValue(2, 3, text);
        }
    }

    TextField {
        id: textB2
        x: 263
        y: 142
        width: 30
        height: 40
        text: qsTr("0")
        horizontalAlignment: Text.AlignRight
        font.pointSize: 10
        onTextEdited: {
            calculator.addValue(2, 4, text);
        }
    }

    TextField {
        id: textA31
        x: 67
        y: 196
        width: 30
        height: 40
        text: qsTr("0")
        horizontalAlignment: Text.AlignRight
        font.pointSize: 10
        onTextEdited: {
            calculator.addValue(3, 1, text);
        }
    }

    TextField {
        id: textA32
        x: 133
        y: 196
        width: 30
        height: 40
        text: qsTr("0")
        horizontalAlignment: Text.AlignRight
        font.pointSize: 10
        onTextEdited: {
            calculator.addValue(3, 2, text);
        }
    }

    TextField {
        id: textA33
        x: 198
        y: 196
        width: 30
        height: 40
        text: qsTr("0")
        horizontalAlignment: Text.AlignRight
        font.pointSize: 10
        onTextEdited: {
            calculator.addValue(3, 3, text);
        }
    }

    TextField {
        id: textB3
        x: 263
        y: 196
        width: 30
        height: 40
        text: qsTr("0")
        horizontalAlignment: Text.AlignRight
        font.pointSize: 10
        onTextEdited: {
            calculator.addValue(3, 4, text);
        }
    }

    Text {
        id: answer1
        x: 112
        y: 327
        width: 30
        height: 23
        color: "#f7d4d4"
        font.pixelSize: 15
    }

    Text {
        id: answer2
        x: 112
        y: 367
        width: 30
        height: 23
        color: "#f7d4d4"
        font.pixelSize: 15
    }

    Text {
        id: answer3
        x: 112
        y: 407
        width: 30
        height: 23
        color: "#f7d4d4"
        font.pixelSize: 15
    }

    Text {
        id: text3
        x: 101
        y: 150
        width: 30
        height: 20
        color: window.primaryColor
        text: qsTr("X₁ +")
        font.pixelSize: 13
        font.bold: true
    }

    Text {
        id: text5
        x: 167
        y: 150
        width: 30
        height: 20
        color: window.primaryColor
        text: qsTr("X₂ +")
        font.pixelSize: 13
        font.bold: true
    }

    Text {
        id: text6
        x: 232
        y: 150
        width: 30
        height: 20
        color: window.primaryColor
        text: qsTr("X₃ =")
        font.pixelSize: 13
        font.bold: true
    }

    Text {
        id: text7
        x: 101
        y: 204
        width: 30
        height: 20
        color: window.primaryColor
        text: qsTr("X₁ +")
        font.pixelSize: 13
        font.bold: true
    }

    Text {
        id: text8
        x: 167
        y: 204
        width: 30
        height: 20
        color: window.primaryColor
        text: qsTr("X₂ +")
        font.pixelSize: 13
        font.bold: true
    }

    Text {
        id: text9
        x: 232
        y: 204
        width: 30
        height: 20
        color: window.primaryColor
        text: qsTr("X₃ =")
        font.pixelSize: 13
        font.bold: true
    }

    Text {
        id: text11
        x: 65
        y: 326
        width: 30
        height: 20
        color: "#c8c8c8"
        text: qsTr("X₁ =")
        font.pixelSize: 16
        font.bold: true
    }

    Text {
        id: text12
        x: 65
        y: 367
        width: 30
        height: 20
        color: "#c8c8c8"
        text: qsTr("X₂ =")
        font.pixelSize: 16
        font.bold: true
    }

    Text {
        id: text13
        x: 65
        y: 407
        width: 30
        height: 20
        color: "#c8c8c8"
        text: qsTr("X₃ =")
        font.pixelSize: 16
        font.bold: true
    }

    // SIDEBAR
    Page { //выплавающее окно с историей
        id: sidebar
        x: window.width
        y: 0
        width: 240
        height: 480
        background: Rectangle {
            width: 240
            height: 480
            color: "#000"
            opacity: 0.7
        }
        states: [
            State { //при нажатии на кнопку 'история' открывается окно с историей
                name: "opened"
                PropertyChanges {
                    target: sidebar
                    x: window.width - 240
                }
                PropertyChanges {
                    target: sidebarLayout
                    y: 0
                }
            },
            State { //
                name: "closed"
                PropertyChanges {
                    target: sidebar
                    x: window.width
                }
                PropertyChanges {
                    target: sidebarLayout
                    y: -window.height
                }
            }
        ]
        transitions: [
            Transition {
                NumberAnimation {
                    properties: "x"
                    easing.type: Easing.OutCubic
                }
            }
        ]

        Text {
            id: text10
            x: 20
            y: 57
            width: 172
            height: 24
            color: "#e6ccd2"
            text: qsTr("История вычислений")
            font.pixelSize: 17
        }

        ListView { //элементы истории
            id: listView
            x: 20
            y: 103
            width: 200
            height: 160
            delegate: Item {
                x: 0
                width: 200
                height: 40
                ItemDelegate {
                    id: itemDelegate
                    x: 0
                    y: 0
                    width: 200
                    height: 40
                    text: window.historyItems[index].name
                    onClicked: {
                        window.onHistoryItemClicked(index);
                    }
                }
            }
            model: 0
        }
    }
    Page { //при нажатии на любую зону окна программы (кроме окна истории) история скроется
        id: sidebarLayout
        x: 0
        y: -window.height
        width: window.width - 240
        height: window.height
        opacity: 0
        TapHandler {
            onSingleTapped: sidebar.state = "closed"
        }
    }

    // WINDOW BAR
    ToolBar {
        id: toolBar
        x: 0
        y: 0
        width: window.width
        height: 24

        visible: true
        background: Rectangle {
            color: "#000"
            opacity: 0.5
        }
        ToolButton {
            x: 0
            y: 0
            width: window.width - 64
            height: 24
            background: Rectangle {
                opacity: 0
            }
            Text {
                width: window.width - 64
                height: 24
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: "#fff"
                font.pixelSize: 14
                text: 'App by Ananina A.'
            }

            MouseArea { //для перемещения окна, при зажатии мышкой
                anchors.fill: parent
                property real lastMouseX: 0
                property real lastMouseY: 0
                onPressed: {
                    lastMouseX = mouseX
                    lastMouseY = mouseY
                }
                onMouseXChanged: window.x += (mouseX - lastMouseX)
                onMouseYChanged: window.y += (mouseY - lastMouseY)
            }
        }
        ToolButton { //конпка сворачивания окна программы
            id: _button
            x: window.width - 64
            y: 0
            width: 32
            height: 24
            background: _ButtonBG
            onHoveredChanged: hovered ? _ButtonBG.opacity = 1 : _ButtonBG.opacity = 0
            onClicked: window.showMinimized()
            Rectangle {
                id: _ButtonBG
                color: "#0c73ba"
                opacity: 0
            }
            Image {
                id: _ButtonImage
                source: "_.png"
                opacity: 0.8
            }
        }
        ToolButton { //кнопка закрытия окна программы
            id: xButton
            x: window.width - 32
            y: 0
            width: 32
            height: 24
            background: xButtonBG
            onHoveredChanged: hovered ? xButtonBG.opacity = 1 : xButtonBG.opacity = 0
            onClicked: window.close()
            Rectangle {
                id: xButtonBG
                color: "#b72f00"
                opacity: 0
            }
            Image {
                id: xButtonImage
                source: "x.png"
                opacity: 0.8
            }
        }
    }

}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.25}
}
##^##*/
