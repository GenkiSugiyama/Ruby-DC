class Brave

  # initializeメソッドを定義
  # new演算子から引数を受け取り任意の初期値を設定する
  # 引数にキーワード指定することでどのパラメーターにどういう値が入るか可読性をあげる
  def initialize(name:, hp:, offense:, defense:)
    @name = "テリー"
    @hp = 500
    @offense = 150
    @defense = 100
  end

  # nameのゲッター
  def name
    @name
  end

  # hpのゲッター
  def hp
    @hp
  end

  # offenseのゲッター
  def offense
    @offense
  end

  # defenseのゲッター
  def defense
    @defense
  end

end

brave = Brave.new(name: "テリー",hp: 500,offense: 150,defense: 100)
puts <<~TEXT
NAME:#{brave.name}
HP:#{brave.hp}
OFFENSE:#{brave.offense}
DEFENSE:#{brave.defense}
TEXT