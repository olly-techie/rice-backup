import QtQuick

// Часы вместо SystemClock: тот ждёт следующей минуты таймером на CLOCK_MONOTONIC, который во сне не идёт,
// поэтому на пробуждении время стоит, пока «дотикает» остаток минуты. date сравнивается по корзинам,
// а не по дельте — переживает и отмотку часов назад (NTP, перелёт). enabled — наследованный от Item: enabled: false глушит всё
Item {
    id: root

    enum Precision { Hours, Minutes, Seconds }

    property int precision: SysClock.Minutes
    property date date: new Date()

    readonly property int step: root.precision === SysClock.Hours ? 3600000 : root.precision === SysClock.Minutes ? 60000 : 1000

    function tick() {
        const now = new Date();
        if (Math.floor(now.getTime() / root.step) !== Math.floor(root.date.getTime() / root.step)) root.date = now;
    }

    Component.onCompleted: tick()

    // кадры — чтобы первый же отрисованный после пробуждения кадр показал верное время; таймер — гарантия,
    // когда кадров нет (статичный экран), там FrameAnimation не выстрелит сама собой
    FrameAnimation {
        running: root.enabled
        onTriggered: root.tick()
    }
    Timer {
        running: root.enabled
        interval: 250
        repeat: true
        onTriggered: root.tick()
    }
}
