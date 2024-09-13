
const crypto = require('crypto');

function getHash(str) {
    return crypto.createHash('sha256').update((str).toString()).digest('hex');
}

console.log(getHash('DevKaran100'));
console.log(getHash('KaranDarsh10'));

