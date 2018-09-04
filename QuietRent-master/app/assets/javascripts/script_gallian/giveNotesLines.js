/* 
give_note.js : 
-------------
1 - take as input a csv file of profiles 
in a Galian format (see dataGalian/Base_echantillon.csv), 
2 - transform the data
to something compatible with the `calcul` (see calculLib/calcul.js)
function
3 - evaluate and save to csv the result  
*/ 

const lodash = require('lodash');
const csv = require('csv-parser');
const fs = require('fs');
/* 
calcul : function which gives the evaluation
it takes an minimal object of that form 
{ 
id: '21590757/2012',
zone: 2,
loyer: 498,
professionel: 4,
age: 25,
salary: 1495.17,
status: 3 
} 
*/
const calcul = require('./calculLib/calcul');
//transform data from Galian to data compatible 
//with the calcul function 
const handleTransform = require('./calculLib/transform');
//the sinitre array was created manually from the sinitre sheet 
//of Galian, when a line has a sinitre it is added in the array
const sinistreList = require('./dataGalian/sinitresArray');


let logger = fs.createWriteStream('liste_notes.csv', {
  flags: 'a' // 'a' means appending (old data will be preserved)
});

//reading the main file
//initialize the counter for display purposes 
let counter = 0;
//write the column name of the resulting csv 
logger.write("id;zone;loyer;professionel;age;salary;status;note;sinistre\n");
//looping through each line of the Galian `base echantillon`
fs.createReadStream('./dataGalian/Base_echantillon.csv').pipe(
  csv({
      separator: ';', // specify optional cell separator
      quote: '"', // specify optional quote character
  }))
  .on('data', function (data) {
    //check that there is an income
    //if not, we skip the line 
    if (lodash.isEmpty(data.Revenus)) {
      return 0;
    }
    //transform Galian data to 
    //compatible one
    let o = handleTransform(data);
    //give a note from the transformed object
    o.note = calcul(lodash.clone(o));
    //set no sinistre unless found in the sinitre database
    o.sinistre = 0;
    //if sinistre found set to 1
    if (sinistreList.indexOf(o.id) !== -1) {
      o.sinistre = 1;
    }

    //display purposes 
    counter++;
    if (counter % 1000 === 0) {
      console.log(counter);
    }
    //write to the csv
    logger.write(o.id + ";" + o.zone + ";" + o.loyer + ";" + o.professionel + ";" + o.age + ";" + o.salary + ";" + o.status + ";" + o.note + ";" + o.sinistre + "\n");
  })
  .on('end', function () {
    logger.end();
  });