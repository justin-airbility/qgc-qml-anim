import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.15
import Qt5Compat.GraphicalEffects

Window {
    width: 400
    height: 240
    visible: true
    color: "#d3d3d3"
    title: "Slide to Arm Demo"

    property bool armed: false
    property bool disarmRequested: false

    Column {
        anchors.centerIn: parent
        spacing: 20

        // Status text
        Text {
            id: statusText
            text: armed ? "ARMED" : "Slide to Arm"
            font.pixelSize: 24
            font.bold: true
            color: armed ? "red" : "limegreen"
            horizontalAlignment: Text.AlignHCenter
            width: parent.width
        }

        // Arming slider
        Rectangle {
            id: sliderTrack
            // MODIFIED: Show the slider during the disarming animation
            visible: !armed || disarmRequested
            width: 300
            height: 50
            radius: height / 2
            color: "#333"
            border.color: "#666"
            border.width: 1

            Rectangle {
                id: knob
                width: 46
                height: 46
                radius: width / 2
                color: "#ccc"
                anchors.verticalCenter: parent.verticalCenter
                x: 2

                property real maxX: sliderTrack.width - width - 2
                property bool dragging: false

                Behavior on x {
                    // MODIFIED: Explicitly reference knob.dragging to fix ReferenceError
                    enabled: !knob.dragging
                    NumberAnimation {
                        duration: 300
                        easing.type: Easing.OutQuad
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    drag.target: parent
                    drag.axis: Drag.XAxis
                    drag.minimumX: 2
                    drag.maximumX: knob.maxX
                    onPressed: {
                        knob.dragging = true
                    }
                    onReleased: {
                        knob.dragging = false
                        if (knob.x >= knob.maxX) {
                            armed = true
                        } else {
                            // Animate back to the start if not dragged to the end
                            knob.x = 2
                            // MODIFIED: Removed confusing and unnecessary timer start
                        }
                    }
                }
            }
        }

        // Disarm overlay button
        Rectangle {
            id: aquaButton
            // MODIFIED: Hide the button during the disarming animation
            visible: armed && !disarmRequested
            width: 200
            height: 60
            radius: 30
            anchors.horizontalCenter: parent.horizontalCenter

            property alias stop1Color: stop1.color
            property alias stop2Color: stop2.color
            property alias stop3Color: stop3.color

            state: visualPressed ? "pressed" : "released"

            property bool pressed: false
            property bool visualPressed: pressed && mouseArea.containsMouse

            gradient: Gradient {
                GradientStop { id: stop1; position: 0.0; color: "#d0e8ff" }
                GradientStop { id: stop2; position: 0.5; color: "#a0c8ff" }
                GradientStop { id: stop3; position: 1.0; color: "#70a0d0" }
            }

            border.color: "#406090"
            border.width: 1

            layer.enabled: true
            layer.effect: DropShadow {
                color: "#808080"
                x: 0
                y: 2
                radius: 6
                samples: 16
            }

            Rectangle {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                height: parent.height * 0.5
                radius: 30
                color: "white"
                opacity: 0.25
                clip: true
            }

            Text {
                anchors.centerIn: parent
                text: "Disarm"
                font.bold: true
                font.pixelSize: 20
                color: "#2e2e2e"
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true

                onPressed: {
                    aquaButton.pressed = true
                }

                onReleased: {
                    aquaButton.pressed = false
                    if (containsMouse) {
                        console.log("Disarm button clicked")
                        disarmRequested = true
                        knob.x = 2 // trigger slide back animation
                        // Wait for animation to finish before disarming
                        disarmTimer.start()
                    }
                }

                onCanceled: {
                    aquaButton.pressed = false
                }
            }

            states: [
                State {
                    name: "released"
                    PropertyChanges { target: stop1; color: "#d0e8ff" }
                    PropertyChanges { target: stop2; color: "#a0c8ff" }
                    PropertyChanges { target: stop3; color: "#70a0d0" }
                },
                State {
                    name: "pressed"
                    PropertyChanges { target: stop1; color: "#a0c8ff" }
                    PropertyChanges { target: stop2; color: "#70a0d0" }
                    PropertyChanges { target: stop3; color: "#5080c0" }
                }
            ]

            transitions: [
                Transition {
                    from: "released"
                    to: "pressed"
                    reversible: true
                    ColorAnimation { target: stop1; duration: 150; property: "color" }
                    ColorAnimation { target: stop2; duration: 150; property: "color" }
                    ColorAnimation { target: stop3; duration: 150; property: "color" }
                }
            ]
        }
    }

    // Graceful disarm delay after animation
    Timer {
        id: disarmTimer
        interval: 350 // slightly longer than knob's animation
        running: false
        repeat: false
        onTriggered: {
            if (disarmRequested) {
                armed = false
                disarmRequested = false
            }
        }
    }
}
