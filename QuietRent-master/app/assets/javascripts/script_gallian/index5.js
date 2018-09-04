var lodash = require('lodash');
var moment = require('moment');
var csv = require('csv-parser');
var fs = require('fs');
var totalHistory = require('./dataGalian/totalHistory');

let giveNote = function(n, note) {
    let noteYear = 9.9*(1-Math.exp(-1*n/3));
    //let k = Math.sqrt(n) - 0.3;
    let newNote = (note + 1*noteYear)/2;
    return newNote;
}

var types = {
    0 : { s : 0, sp : 0, t : 0, amount : 0, duration : 0},
    1 : { s : 0, sp : 0, t : 0, amount : 0, duration : 0},
    2:  { s : 0, sp : 0, t : 0, amount : 0, duration : 0},
    3 : { s : 0, sp : 0, t : 0, amount : 0, duration : 0},
    4 : { s : 0, sp : 0, t : 0, amount : 0, duration : 0},
    5 : { s : 0, sp : 0, t : 0, amount : 0, duration : 0},
    6 : { s : 0, sp : 0, t : 0, amount : 0, duration : 0},
    7 : { s : 0, sp : 0, t : 0, amount : 0, duration : 0},
    8 : { s : 0, sp : 0, t : 0, amount : 0, duration : 0},
    9 : { s : 0, sp : 0, t : 0, amount : 0, duration : 0},
    10 : { s : 0, sp : 0, t : 0, amount : 0, duration : 0}
};

//add the note regarding the history
totalHistory = totalHistory.map(function (client) {
    client.newNote = null;
    if(lodash.isFinite(client.notes)) {
        client.newNote = giveNote(client.nb, client.notes);
    }
    return client;
});


totalHistory.forEach(function(client) {
//---------
if(!client.newNote) return 0;
let type = Math.ceil(client.newNote);
if(type > 10) return 0;
if(client.sinistre) {
    types[type].s = types[type].s + 1;
}
types[type].t = types[type].t + 1;
//---------
});


for(key in types) {
    if(types[key].t > 0) {
        types[key].p =  (types[key].s/types[key].t)*100;
    } else {
        types[key].p = 0;
    }
}

for(key in types) {
    console.log(key + ' ' +  types[key].s + ' ' + types[key].t + ' ' + types[key].p);
}

//console.log(types);



