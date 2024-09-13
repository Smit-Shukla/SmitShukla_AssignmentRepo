const crypto = require('crypto');


function getHash(str) {
    let start = 0;
    while(true) {
        const hash = crypto.createHash('sha256').update((str + start).toString()).digest('hex');
        if(hash.startsWith('00000'))
            return str + start;
        ++start;
    }
}

console.log(getHash('devadnani26'))