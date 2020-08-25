class Brave

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

brave = Brave.new(name: "テリー", hp: 500, offense: 150, defense: 100)
puts <<~TEXT
NAME:#{brave.name}
HP:#{brave.hp}
OFFENSE:#{brave.offense}
DEFENSE:#{brave.defense}
TEXT