#  Characterクラスを別ファイルに分割
require './character'


# Characterクラスを継承
class Brave < Character

  # Characterクラスの継承で不要になった
  # attr_reader :name, :offense, :defense
  # attr_accessor :hp

  # 必殺攻撃に使う倍率を定数として定義しておく
  SPECIAL_ATTACK_CONSTANT = 1.5

  # Characterクラスの継承で不要になった
  # def initialize(**params)
  #   # paramsで受け取った値の中からハッシュで受け取る値を指定
  #   @name = params[:name]
  #   @hp = params[:hp]
  #   @offense = params[:offense]
  #   @defense = params[:defense]
  # end

  # 攻撃処理を実装
  # 引数に攻撃対象となるモンスタークラスのインスタンスを受け取る
  def attack(monster)
    puts "#{@name}の攻撃"

    # 攻撃を判定するメソッドを呼び出し
    attack_type = decision_attack_type

    # ダメージ計算メソッド抜き出し
    damage = caluclate_damage(target: monster, attack_type: attack_type)

    # ダメージをhpに反映させる
    cause_damage(target: monster, damage: damage)

    puts "#{monster.name}の残りHPは#{monster.hp}だ"
  end

  private

  def decision_attack_type
    # 必殺攻撃と通常攻撃の切り分け（4分の1の確率で必殺攻撃を行う）
    # 0~3の間のランダムに数字が変わる
    attack_num = rand(4)

    if attack_num == 0
      # 必殺攻撃
      puts "必殺攻撃"
      "special_attack"
    else
      # 通常攻撃（ダメージ計算：勇者の攻撃力 - モンスターの守備力）
      puts "通常攻撃"
      "normal_attack"
    end
  end

  def caluclate_damage(**params)
    target = params[:target]
    attack_type = params[:attack_type]

    # attack_typeを使って切り分け
    if attack_type == "special_attack"
      calculate_special_attack - target.defense
    else
      @offense - target.defense
    end
  end

  def cause_damage(**params)
    target = params[:target]
    damage = params[:damage]

    # 攻撃対象のモンスターHPからダメージ分を引く
    target.hp -= damage

    # 攻撃対象のHPがマイナスなら0を代入
    target.hp = 0 if target.hp < 0

    puts "#{target.name}は#{damage}のダメージを受けた"
  end

  def calculate_special_attack
    @offense * SPECIAL_ATTACK_CONSTANT
  end
end

class Monster < Character

  # Characterクラスの継承で不要になった
  # attr_reader :offense, :defense
  # attr_accessor :hp,:name

  # 変身時の攻撃力UPの倍数
  MONSTER_SPECIAL_CONSTANT = 2
  # HPの半分の値を計算する定数
  CALC_HALF_HP = 0.5

  def initialize(**params)
    # Characterクラスの継承で不要になった
    # @name = params[:name]
    # @hp = params[:hp]
    # @offense = params[:offense]
    # @defense = params[:defense]

    # 親クラスのinitializeメソッド内の処理を上書き
    super(
      name: params[:name],
      hp: params[:hp],
      offense: params[:offense],
      defense: params[:defense]
    )

    # 親クラスで定義していない処理はそのまま
    @change = false
    @half_hp = params[:hp] * CALC_HALF_HP
  end

  # モンスターの攻撃処理を実装
  def attack(brave)
    puts "モンスターのターン"
    # そのときのHPが半分以下で変身フラグがfalseの場合transformメソッドを発火
    if @hp <= @half_hp && @change == false
      # 変身フラグをtrue（変身済み）にした上でtransformメソッドを呼び出す
      @change = true
      transform
    end

    puts "#{@name}の攻撃"

    # ダメージ計算処理は別メソッドに切り出し
    damage = caluclate_damage(brave)

    # ダメージのHPへの反映も別メソッドに切り出し
    cause_damage(target: brave, damage: damage)

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

  # ダメージ計算
  def caluclate_damage(brave)
    @offense - brave.defense
  end

  # ダメージをHPに反映
  def cause_damage(**params)
    target = params[:target]
    damage = params[:damage]
    puts "#{target.name}は#{damage}のダメージを受けた"
    target.hp -= damage
    # 攻撃対象のHPがマイナスなら0を代入
    target.hp = 0 if target.hp < 0
  end
end

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
