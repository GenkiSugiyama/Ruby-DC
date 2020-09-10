# BraveクラスとMonsterクラスをファイル分割
# Characterクラスはこのファイルでは扱わないのでrequireしない
require './brave'
require './monster'

brave = Brave.new(name: "テリー", hp: 500, offense: 150, defense: 100)
monster = Monster.new(name: "スライム", hp: 250, offense: 200, defense: 100)

# loop doでループ処理
loop do
  brave.attack(monster)

  # モンスターのHPが0になったらループ処理を終了する
  if monster.hp <= 0
    break
  end

  monster.attack(brave)

  # 勇者のHPが0になったらループ処理を終了する
  if brave.hp <= 0
    break
  end
end
