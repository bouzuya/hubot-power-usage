# Description
#   A Hubot script that show power usage
#
# Configuration:
#   HUBOT_POWER_USAGE_APP_ID
#
# Commands:
#   hubot power-usage <hokkaido|tohoku|tokyo|chubu|kansai|kyushu> - show power usage
#
# Author:
#   bouzuya <m@bouzuya.net>
#
module.exports = (robot) ->
  APP_ID = process.env.HUBOT_POWER_USAGE_APP_ID
  areas = ['hokkaido', 'tohoku', 'tokyo', 'chubu', 'kansai', 'kyushu']

  pattern = new RegExp('power-usage (' + areas.join('|') + ')?', 'i')
  robot.respond pattern, (res) ->
    area = res.match[1]
    return res.send('hubot power-usage <' + areas.join('|') + '>') unless area?
    url = 'http://setsuden.yahooapis.jp/v1/Setsuden/latestPowerUsage?appid=' + APP_ID + '&output=json&area=' + area
    res.http(url).get() (err, _, body) ->
      return res.send(err) if err?
      json = JSON.parse(body)
      usage = json.ElectricPowerUsage.Usage.$
      cap = json.ElectricPowerUsage.Capacity.$
      date = json.ElectricPowerUsage.Date
      hour = json.ElectricPowerUsage.Hour
      per = Math.floor(usage / cap * 100)
      res.send "#{area} #{date} #{hour}:00 #{usage} kW / #{cap} kW (#{per}%)"
