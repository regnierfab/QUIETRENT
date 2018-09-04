/* 
That file allow the transformation 
of Galian compatible data to 
data compatible with the `calcul` function 
*/

let lodash = require('lodash');
let moment = require('moment');

let regions = 
{ 
'Normandie' : 'B',
'IDF' : 'A',
'Midi-Pyrénées' : 'C',
'Lorraine' : 'B',
'Picardie': 'C',
'Nord-Pas-de-Calais' : 'B',
'manquante' : 'C',
'Poitou-Charentes' : 'C',
'Alsace' : 'C',
'Bourgogne' : 'C',
'Rhône-Alpes' : 'C',
'PACA' : 'B',
'Languedoc-Roussillon' : 'C',
'Auvergne': 'C',
'Centre': 'C',
'Corse' : 'B',
'Aquitaine': 'C',
'Pays-de-la-Loire' : 'C',
'Limousin': 'C',
'Bretagne' : 'B',
'Champagne-Ardenne': 'C',
'Franche-Comté': 'C',
'D.O.M.' : 'C' 
};

let contrat = 
{ 
  'CDI_confirme' : "CDI définitif", 
  'Autre' : "libéral - 3ans", 
  'CDD' : "CDD +12 mois", 
  'Aucun' : "Sans emploi", 
  'Intérim' : "Précaire", 
  'empty' : "CDI en essaie"
};

let transform = {
    "id": {
      k: "Identifiant_lot",
      f: function (v) { return v; }
    },
    "zone": {
      k: "Région ",
      f: function (v) { return regions[v]; }
    },
    "loyer": {
      k: "Loyer global",
      f: function (v) { return parseFloat(v.replace(',', '.')) }
    },
    "professionel": {
      k: "Contrat 1er locataire",
      f: function (v) {
        v = lodash.isEmpty(v) ? 'empty' : v; 
        return contrat[v]; 
      }
    },
    "age": {
      k: "Date de naissance 1er locataire",
      f: function (v) {
        let birth = moment(v, "DD/MM/YYYY");
        return moment().diff(birth, 'year');
      }
    },
    "salary": {
      k: "Revenus",
      f: function (v) { return parseFloat(v.replace(',', '.')) }
    },
    "status": {
      k: "Nb locataires dans les lieux",
      f: function (v) {
        v = parseFloat(v);
        if(v > 1) {
          return "couple";
        }
        return "célibataire";
      }
    }
  }


  module.exports =  function handleTransform(e) {
    let o = {};
    for(key in transform) {
      let v = e[transform[key].k];
      o[key] = transform[key].f(v);
    }
    return o;
  }