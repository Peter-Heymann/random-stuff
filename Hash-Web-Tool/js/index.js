const password = reqire('password-gen-v1')

const passwordWeak = password.newPassword(8)
const passwordNormal = password.newPassword(16)
const passwordStrong = password.newPassword(24)
const passwordHard = password.newPassword(64)

console.log(passwordWeak)
console.log(passwordNormal)
console.log(passwordStrong)
console.log(passwordHard)

function copyPasswordWeak() {
    let copyText = document.getElementById("weakPassword");
    copyText.select();
    copyText.setSelectionRange(0, 99999);
    document.execCommand("copy");
    alert("Copied the text: " + copyText.value);
}
function copyPasswordNormal() {
    let copyText = document.getElementById("NormalPassword");
    copyText.select();
    copyText.setSelectionRange(0, 99999);
    document.execCommand("copy");
    alert("Copied the text: " + copyText.value);
}
function copyPasswordStrong() {
    let copyText = document.getElementById("StrongPassword");
    copyText.select();
    copyText.setSelectionRange(0, 99999);
    document.execCommand("copy");
    alert("Copied the text: " + copyText.value);
}
function copyPasswordHard() {
    let copyText = document.getElementById("HardPassword");
    copyText.select();
    copyText.setSelectionRange(0, 99999);
    document.execCommand("copy");
    alert("Copied the text: " + copyText.value);
}