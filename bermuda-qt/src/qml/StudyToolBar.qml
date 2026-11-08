import QtQuick
import QtQuick.Controls

// Study actions stay beside the board tools and wrap on narrower windows.
Flow {
    id: tools
    spacing: 4
    property bool canEditMoves: true
    property string activeTool: ""
    signal toolSelected(string tool)
    signal searchOptionsRequested(real x, real y)
    signal saveRequested()

    Button {
        objectName: "studyNotes"
        text: qsTr("Game / notes")
        enabled: tools.canEditMoves
        highlighted: tools.activeTool === "notes"
        onClicked: tools.toolSelected("notes")
    }
    Button {
        objectName: "studyMoves"
        text: qsTr("Moves / variations")
        enabled: tools.canEditMoves
        highlighted: tools.activeTool === "moves"
        ToolTip.visible: hovered
        ToolTip.text: qsTr("Play a different continuation on the board to create a branch. The original line is kept.")
        onClicked: tools.toolSelected("moves")
    }
    Row {
        spacing: 0
        Button {
            objectName: "studyPattern"
            text: qsTr("Pattern search")
            highlighted: tools.activeTool === "pattern"
            onClicked: tools.toolSelected("pattern")
        }
        Button {
            objectName: "studyPatternOptions"
            text: "▾"
            implicitWidth: 28
            highlighted: tools.activeTool === "pattern"
            Accessible.name: qsTr("Pattern search options")
            ToolTip.visible: hovered
            ToolTip.text: qsTr("Pattern search options")
            onClicked: {
                tools.toolSelected("pattern")
                const position = mapToItem(tools, 0, height)
                tools.searchOptionsRequested(position.x, position.y)
            }
        }
    }
    Button {
        objectName: "studyKataGo"
        text: qsTr("KataGo")
        highlighted: tools.activeTool === "katago"
        onClicked: tools.toolSelected("katago")
    }
    Button {
        objectName: "studyInfluence"
        text: qsTr("Influence")
        highlighted: tools.activeTool === "influence"
        onClicked: tools.toolSelected("influence")
    }
    Button {
        objectName: "studySave"
        text: qsTr("Save study")
        ToolTip.visible: hovered
        ToolTip.text: qsTr("Keep this game and its variations in Saved studies. Saving again updates the same study.")
        onClicked: tools.saveRequested()
    }
}
