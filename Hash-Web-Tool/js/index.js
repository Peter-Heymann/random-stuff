const password = reqire('password-gen-v1')

const passwordNormal = password.newPassword(16)
const passwordStrong = password.newPassword(24)
const passwordHard = password.newPassword(64)

console.log(passwordNormal)
console.log(passwordStrong)
console.log(passwordHard)