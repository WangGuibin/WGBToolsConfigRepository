function setClipboardText(value) {
    const text = document.createElement("textarea");
    text.value = value;
    document.body.appendChild(text);
    text.select();
    document.execCommand("Copy");
    text.remove();
}

var btn1 = document.getElementById("nowarp");
var btn2 = document.getElementById("two-space");
var btn3 = document.getElementById("four-space");
var btn4 = document.getElementById("copy-btn");
btn1.onclick = function () {
    var inputDom = document.getElementById("input");
    var outputDom = document.getElementById("output");
    var obj = JSON.parse(inputDom.value)
    outputDom.innerText = JSON.stringify(obj)
};

btn2.onclick = function () {
    var inputDom = document.getElementById("input");
    var outputDom = document.getElementById("output");
    var obj = JSON.parse(inputDom.value)
    outputDom.innerText = JSON.stringify(obj, null, 2)
};

btn3.onclick = function () {
    var inputDom = document.getElementById("input");
    var outputDom = document.getElementById("output");
    var obj = JSON.parse(inputDom.value)
    outputDom.innerText = JSON.stringify(obj, null, 4)
}
btn4.onclick = function () {
    var resultText = document.getElementById("output").innerText;
    setClipboardText(resultText);
    alert('复制成功' + '\n' + resultText);
}
