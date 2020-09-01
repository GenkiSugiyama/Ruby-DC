class Brave

  # attr_readerでゲッターの記述を代替する
  attr_reader :name, :offense, :defense
  # attr_writerでセッターの記述を代替する
  # attr_writer :hp
  # 値の参照（ゲッター）と値の更新（セッター）をattr_accessorで同時に定義する
  attr_accessor :hp

  # 必殺攻撃に使う倍率を定数として定義しておく
  SPECIAL_ATTACK_CONSTANT = 1.5

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

  # 攻撃処理を実装
  # 引数に攻撃対象となるモンスタークラスのインスタンスを受け取る
  def attack(monster)
    puts "#{@name}の攻撃"

    # 必殺攻撃と通常攻撃の切り分け（4分の1の確率で必殺攻撃を行う）
    # 0~3の間のランダムに数字が変わる
    attack_num = rand(4)

    # 4分の1の確率で必殺攻撃を行う
    if attack_num == 0
      # 必殺攻撃
      puts "必殺攻撃"
      damage = calculate_special_attack - monster.defense
    else
      # 通常攻撃（ダメージ計算：勇者の攻撃力 - モンスターの守備力）
      puts "通常攻撃"
      damage = @offense - monster.defense
    end

    # 攻撃対象のモンスターHPからダメージ分を引く
    monster.hp -= damage

    puts "#{monster.name}は#{damage}のダメージを受けた"
    puts "#{monster.name}の残りHPは#{monster.hp}だ"
  end

  def calculate_special_attack
    @offense * SPECIAL_ATTACK_CONSTANT
  end

end

class Monster
  # name, offense, defense属性は値の取り出し（ゲッター）のみ
  attr_reader :offense, :defense
  # hpは取り出し、代入が可能
  # 変身時名前を変更するためnameを読み書き可能に
  attr_accessor :hp,:name

  # 変身時の攻撃力UPの倍数
  MONSTER_SPECIAL_CONSTANT = 2
  # HPの半分の値を計算する定数
  CALC_HALF_HP = 0.5

  # new演算子の引数を受け取って初期値を設定
  def initialize(**params)
    @name = params[:name]
    @hp = params[:hp]
    @offense = params[:offense]
    @defense = params[:defense]
    # 変身するかどうかのフラグ
    @change = false
    # 現在のHPが初期HPの半分かどうかの閾値算出
    @half_hp = params[:hp] * CALC_HALF_HP
  end

  # モンスターの攻撃処理を実装
  def attack(brave)
    # そのときのHPが半分以下で変身フラグがfalseの場合transformメソッドを発火
    if @hp <= @half_hp && @change == false
      transform
    end

    puts "#{@name}の攻撃"

    damage = @offense - brave.defense
    brave.hp -= damage

    puts "#{brave.name}は#{damage}のダメージを受けた"
    puts "#{brave.name}の残りHPは#{brave.hp}だ"
  end

  private

  # クラス外からは呼び出さないのでprivate以下に記述
  def transform
    # フラグをtrueに変更
    @change = true
    # 変身後の名前を定義
    transform_name = "ドラゴン"
    puts "#{@name}は怒っている"
    puts "#{@name}は#{transform_name}に変身した"
    # 攻撃力の変更
    @offense *= MONSTER_SPECIAL_CONSTANT
    # 一度変身した後はインスタンスの名前を変身後のものにする
    @name = transform_name
  end

end

brave = Brave.new(name: "テリー", hp: 500, offense: 150, defense: 100)
monster = Monster.new(name: "スライム", hp: 250, offense: 200, defense: 100)

brave.attack(monster)
monster.attack(brave)
puts "#{monster.name}"
