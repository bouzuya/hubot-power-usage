// Description
//   A Hubot script that show power usage
//
// Configuration:
//   HUBOT_POWER_USAGE_APP_ID
//
// Commands:
//   hubot power-usage <hokkaido|tohoku|tokyo|chubu|kansai|kyushu> - show power usage
//
// Author:
//   bouzuya <m@bouzuya.net>
//
module.exports = function(robot) {
  var APP_ID, areas, pattern;
  APP_ID = process.env.HUBOT_POWER_USAGE_APP_ID;
  areas = ['hokkaido', 'tohoku', 'tokyo', 'chubu', 'kansai', 'kyushu'];
  pattern = new RegExp('power-usage (' + areas.join('|') + ')?', 'i');
  return robot.respond(pattern, function(res) {
    var area, url;
    area = res.match[1];
    if (area == null) {
      return res.send('hubot power-usage <' + areas.join('|') + '>');
    }
    url = 'http://setsuden.yahooapis.jp/v1/Setsuden/latestPowerUsage?appid=' + APP_ID + '&output=json&area=' + area;
    return res.http(url).get()(function(err, _, body) {
      var cap, date, hour, json, per, usage;
      if (err != null) {
        return res.send(err);
      }
      json = JSON.parse(body);
      usage = json.ElectricPowerUsage.Usage.$;
      cap = json.ElectricPowerUsage.Capacity.$;
      date = json.ElectricPowerUsage.Date;
      hour = json.ElectricPowerUsage.Hour;
      per = Math.floor(usage / cap * 100);
      return res.send("" + area + " " + date + " " + hour + ":00 " + usage + " kW / " + cap + " kW (" + per + "%)");
    });
  });
};
