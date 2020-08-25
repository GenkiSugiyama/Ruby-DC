class Brave

  # initializeメソッドを定義
  # Object.newで新しいインスタンスを作った時にinitializeメソッドで定義された初期値をパラメーターに格納する
  def initialize
    @name = "テリー"
    @hp = 500
    @offense = 150
    @defense = 100
  end

  # このクラスが持つパラメータの設定をセッターメソッドを使って行う
  # nameのセッター
  # 関数名=(引数名) とするのはセッターだから
  # def name=(name)
  #   @name = name
  # end

  # nameのゲッター
  def name
    @name
  end

  # hpのセッター
  # def hp=(hp)
  #   @hp = hp
  # end

  # hpのゲッター
  def hp
    @hp
  end

  # offenseのセッター
  # def offense=(offense)
  #   @offense = offense
  # end

  # offenseのゲッター
  def offense
    @offense
  end

  # defenseのセッター
  # def defense=(defense)
  #   @defense = defense
  # end

  # defenseのゲッター
  def defense
    @defense
  end

end

# initializeメソッド定義したことにより不要となる
# brave = Brave.new
# brave.name = "テリー"
# brave.hp = 500
# brave.offense = 150
# brave.defense = 100

brave = Brave.new
puts <<~TEXT
NAME:#{brave.name}
HP:#{brave.hp}
OFFENSE:#{brave.offense}
DEFENSE:#{brave.defense}
TEXT