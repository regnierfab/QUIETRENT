var lodash = require('lodash');
var moment = require('moment');
var csv = require('csv-parser');
var fs = require('fs');
var calcul = require('./calculLib/calcul');
var sinistreList = require('./dataGalian/sinitresArray');
var Sinitres = require('./dataGalian/sinitres');
var events = require('events');
var logger = fs.createWriteStream('note.txt', {
    flags: 'a' // 'a' means appending (old data will be preserved)
  });


var categories = {
    1 : [0,0,0,0,0,0,0,0,0,0,0],
    2 : [0,0,0,0,0,0,0,0,0,0,0],
    3 : [0,0,0,0,0,0,0,0,0,0,0]
}

fs.createReadStream('./dataGalian/note.csv')
.pipe(csv({
    separator: ';', // specify optional cell separator
    quote: '"',     // specify optional quote character
  }))
.on('data', function (data) {
    //console.log("A", data.loyer, data.salary);
    //if(lodash.isFinite(data.loyer) && lodash.isFinite(data.salary)) {
        //console.log("B")
        let te = data.loyer/data.salary;
        //console.log(te); 
        if(te < 0.15) {
            categories[1][0]++;
            let note = Math.ceil(data.note);
            categories[1][note]++;
        } 
        if(te >= 0.15 && te < 0.33) {
            categories[2][0]++;
            let note = Math.ceil(data.note);
            categories[2][note]++;
        } 
        if(te >= 0.33) {
            categories[3][0]++;
            let note = Math.ceil(data.note);
            categories[3][note]++;
        } 
    //}
    //logger.write(o.id + ";" + o.zone + ";" + o.loyer + ";" + o.professionel + ";" + o.age + ";" + o.salary + ";" + o.status + ";" + o.note + ";" + o.sinistre + "\n");     
})
.on('end', function() {
    logger.end();  
    //console.log(categories);  
    for(var key in categories) {
        let total = categories[key][0];
        categories[key] = categories[key].map((e) => { return e/total });
    }
    //console.log(categories);
    for(var i=1; i<= 10; i++) {
        console.log(i, categories[1][i], categories[2][i], categories[2][i]);
    }
});