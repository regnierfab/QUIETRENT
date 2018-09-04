const helpers = {
    parseNumber : function(num) {
        if(lodash.isFinite(num)) {
            return num;
        } else {
            return parseFloat(num.replace(/\s/,'')) || 0;
        }
    }
}

module.exports = helpers;