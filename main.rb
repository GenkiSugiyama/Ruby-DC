class Brave

  # attr_readerでゲッターの記述を代替する
  attr_reader :name, :offense, :defense
  # attr_writerでセッターの記述を代替する
  # attr_writer :hp
  # 値の参照（ゲッター）と値の更新（セッター）をattr_accessorで同時に定義する
  attr_accessor :hp

  # initializeメソッドを定義
  # new演算子から引数を受け取り任意の初期値を設定する
  # 引数にparamsを指定し一括で受け取る
  # 引数に**をつけることで受け取れる引数をハッシュのみに限定する
  def initialize(**params)
    # paramsで受け取った値の中からハッシュで受け取る値を指定
    @name = params[:name]
    @hp = params[:hp]
    @offense = params[:offense]
    @defense = params[:defense]
  end

end

brave = Brave.new(name: "テリー", hp: 500, offense: 150, defense: 100)

class Monster
  # name, offense, defense属性は値の取り出し（ゲッター）のみ
  attr_reader :name, :offense, :defense
  # hpは取り出し、代入が可能
  attr_accessor :hp

  # new演算子の引数を受け取って初期値を設定
  def initialize(**params)
    @name = params[:name]
    @hp = params[:hp]
    @offense = params[:offense]
    @defencse = params[:defencse]
  end
end

monster = Monster.new(name: "スライム", hp: 250, offense: 200, defense: 100)

puts <<~TEXT
NAME:#{brave.name}
HP:#{brave.hp}
OFFENSE:#{brave.offense}
DEFENSE:#{brave.defense}
TEXT

puts <<~TEXT
NAME:#{monster.name}
HP:#{monster.hp}
OFFENSE:#{monster.offense}
DEFENSE:#{monster.defense}
TEXT

brave.hp -= 30

puts "#{brave.name}は#{monster.name}からダメージを受けた!　残りHPは#{brave.hp}だ"