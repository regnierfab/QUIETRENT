var lodash = require('lodash');
//data reference
var Data = require('../dataReferences/data');
var DataEvaluation = require('../dataReferences/dataEvaluation');
var Scale = require('../dataReferences/scale');
var fields = require('../dataReferences/fields');

//function to convert an entry 
//to its numeric equivalent
function convert(entry) {
    for (key in entry) {
        var scale = lodash.get(Scale, key);
        if (scale) {
            var equivalent = lodash.get(scale, entry[key]);
            if (equivalent) {
                entry[key] = equivalent;
            }
        }
    }
    return entry;
}

//evaluate a proximity
//of two entries
function proximity(e1, e2) {

    //check fields that are present in both entries
    let fields1 = Object.keys(e1);
    let fields2 = Object.keys(e2);
    let intersection = lodash.intersection(fields2, fields1);
    //keep only these fields
    fieldsi = lodash.pick(fields, intersection);

    var total = 0;
    for (var field in fieldsi) {

        //check that we have non zero values
        e1[field] = !e1[field] ? fields[field].min : e1[field];
        e2[field] = !e2[field] ? fields[field].min : e2[field];

        var ratio = e1[field] / e2[field];
        if (ratio > 1) {
            ratio = 1 / ratio;
        }
        total += fieldsi[field].k * ratio * ratio;
    }
    return Math.sqrt(total);
}

//give a note according the proximity 
function giveNote(maxProximity, proximity, note) {
    var epsilon = 0.001
    var K = 1/Math.pow((maxProximity - proximity) + epsilon, 1);
    var maxK = 1/Math.pow(epsilon,1);
    var Kf = K/maxK;
    return { note : note*Kf, Kf : Kf };
}

//1. convert the Data to its numeric equivalent
Data = Data.map(function (e) {
    return convert(e);
});


module.exports = function calculateForOneEntry(entry) {
//1.2. convert the entry to its numeric equivalent 
entry = convert(entry);

//3. calculate the maximum proximity
var maxProximity = proximity(entry, entry);

var proximityArray = [];
//3. calculate proximity for each datas
Data.forEach(function (d) {
    var note = lodash.find(DataEvaluation, { "IdDossier": d.id });
    if (note) {
        var proximityA = proximity(d, entry);
        var noteA = note["NoteSolvabilite"];
        var noteBalance = giveNote(maxProximity, proximityA, noteA);

        proximityArray.push({
            id : d.id,
            proximity : proximityA,
            evaluation : noteA,
            balanced : noteBalance.note,
            Kf : noteBalance.Kf
        });
    }
});

//sort the Array 
proximityArray = lodash.sortBy(proximityArray, function(o) { return -1*o.proximity });

//5.0 Display the array 
//console.log(proximityArray);

//6.0 calculate the note 
//slice the proximity array 
proximityArray = proximityArray.slice(0,10);

var sumTotal = 0;
var sumCoef = 0;

proximityArray.forEach(function(o) {
    sumTotal += o.balanced;
    sumCoef += o.Kf;
});


return sumTotal/sumCoef;
}
