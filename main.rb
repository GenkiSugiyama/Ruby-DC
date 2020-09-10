# BraveクラスとMonsterクラスをファイル分割
# Characterクラスはこのファイルでは扱わないのでrequireしない
require './brave'
require './monster'
require './games_controller'

games_controller = GamesController.new

brave = Brave.new(name: "テリー", hp: 500, offense: 150, defense: 100)
monster = Monster.new(name: "スライム", hp: 250, offense: 200, defense: 100)

games_controller.battle(brave: brave, monster: monster)