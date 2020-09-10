require './character'

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