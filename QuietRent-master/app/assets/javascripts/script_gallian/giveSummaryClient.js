const lodash = require('lodash');
const csv = require('csv-parser');
const fs = require('fs');
const sinitres = require('./dataGalian/sinitres');
const helpers = require('./lib/helpers');

//filter per year 
//none when there is
//no filter 
let year = "none";

//it allows to make some 
//interesting statistic per notes-categories 
let types = {
    0: {
        s: 0,
        sp: 0,
        t: 0,
        amount: 0,
        duration: 0
    },
    1: {
        s: 0,
        sp: 0,
        t: 0,
        amount: 0,
        duration: 0
    },
    2: {
        s: 0,
        sp: 0,
        t: 0,
        amount: 0,
        duration: 0
    },
    3: {
        s: 0,
        sp: 0,
        t: 0,
        amount: 0,
        duration: 0
    },
    4: {
        s: 0,
        sp: 0,
        t: 0,
        amount: 0,
        duration: 0
    },
    5: {
        s: 0,
        sp: 0,
        t: 0,
        amount: 0,
        duration: 0
    },
    6: {
        s: 0,
        sp: 0,
        t: 0,
        amount: 0,
        duration: 0
    },
    7: {
        s: 0,
        sp: 0,
        t: 0,
        amount: 0,
        duration: 0
    },
    8: {
        s: 0,
        sp: 0,
        t: 0,
        amount: 0,
        duration: 0
    },
    9: {
        s: 0,
        sp: 0,
        t: 0,
        amount: 0,
        duration: 0
    },
    10: {
        s: 0,
        sp: 0,
        t: 0,
        amount: 0,
        duration: 0
    }
};

/* 
var yearDurations = {
    1 : { n : 0, sumNote : 0 },
    2 : { n : 0, sumNote : 0 },
    3 : { n : 0, sumNote : 0 },
    4 : { n : 0, sumNote : 0 },
    5 : { n : 0, sumNote : 0 },
    6 : { n : 0, sumNote : 0 },
    7 : { n : 0, sumNote : 0 },
    8 : { n : 0, sumNote : 0 },
    9 : { n : 0, sumNote : 0 },
    10 : { n : 0, sumNote : 0 },
}; 
*/

counter = 0;
totalCounter = 0;
let groupeArray = [];


fs.createReadStream('./dataGalian/note.csv')
    .pipe(csv({
        separator: ';', // specify optional cell separator
        quote: '"', // specify optional quote character
    }))
    .on('data', function (data) {
        let idClient = data.id.slice(0, -5);
        let yearClient = data.id.slice(-4);
        data.yearClient = yearClient;
        
        let indexClient = lodash.findIndex(groupeArray, {
            idClient
        });

        if (indexClient !== -1) {
            groupeArray[indexClient].arr.push(data);
        } else {
            groupeArray.push({
                idClient,
                arr: [data]
            });
        }

        //filter per year
        if (lodash.isFinite(year)) {
            if (yearClient !== year.toString()) {
                return 0;
            }
        }


        let type = Math.ceil(data.note);
        if (data.sinistre === '1') {
            counter++;
            types[type].s = types[type].s + 1;

            let addData = lodash.find(sinitres, {
                "Identifiant_lot": data.id
            });
            types[type].amount += helpers.parseNumber(addData["Charge nette"]);
            let monthDuration = helpers.parseNumber(addData["Montant Règlements en principal"]) / parseNumber(addData["Montant du loyer sinistré"]);

            if (lodash.isFinite(monthDuration)) {
                types[type].duration += monthDuration;
                types[type].sp = types[type].sp + 1;
            }
        }
        types[type].t = types[type].t + 1;
    })
    .on('end', function () {
        for (key in types) {
            if (types[key].t > 0) {
                types[key].p = (types[key].s / types[key].t) * 100;
            } else {
                types[key].p = 0;
            }

            if (types[key].s > 0) {
                types[key].amountP = (types[key].amount / types[key].s);
            } else {
                types[key].amountP = 0;
            }

            if (types[key].sp > 0) {
                types[key].durationP = (types[key].duration / types[key].sp);
            } else {
                types[key].durationP = 0;
            }

        }

        //work on historic
        //console.log(groupeArray);
        let historic = [];
        let totalHistoric = [];
        groupeArray.forEach(function (client) {
            //console.log(client.arr);
            let isSinitre = client.arr.some(function (y) {
                return y.sinistre == 1;
            });

            /*
            if(isSinitre) {
                historic.push({
                    id : client.idClient,
                    nb : client.arr.length,
                    year : client.arr.map((o) => { return o.yearClient }),
                    notes : client.arr.map((o) => { return o.note })
                });
            }
            */

            totalHistoric.push({
                id: client.idClient,
                nb: client.arr.length,
                //year : client.arr.map((o) => { return o.yearClient }),
                notes: lodash.mean(client.arr.map((o) => {
                    return o.note
                })),
                sinistre: isSinitre
            })
        });
        console.log(JSON.stringify(totalHistoric));
    });