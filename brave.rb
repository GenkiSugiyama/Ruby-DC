require './character'

class Brave < Character

  # 必殺攻撃に使う倍率を定数として定義しておく
  SPECIAL_ATTACK_CONSTANT = 1.5

  # 攻撃処理を実装
  # 引数に攻撃対象となるモンスタークラスのインスタンスを受け取る
  def attack(monster)

    # 攻撃を判定するメソッドを呼び出し
    attack_type = decision_attack_type

    # ダメージ計算メソッド抜き出し
    damage = caluclate_damage(target: monster, attack_type: attack_type)

    # ダメージをhpに反映させる
    cause_damage(target: monster, damage: damage)

    # MessageDialogモジュールのattack_messageを呼び出し
    # attack_message内で攻撃種別の表示を切り替えるための引数を渡す
    attack_message(attack_type: attack_type)

    # damage_messageの呼び出し
    damage_message(target: monster, damage: damage)
  end

  private

  def decision_attack_type
    # 必殺攻撃と通常攻撃の切り分け（4分の1の確率で必殺攻撃を行う）
    # 0~3の間のランダムに数字が変わる
    attack_num = rand(4)

    if attack_num == 0
      # 必殺攻撃
      "special_attack"
    else
      # 通常攻撃（ダメージ計算：勇者の攻撃力 - モンスターの守備力）
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

  end

  def calculate_special_attack
    @offense * SPECIAL_ATTACK_CONSTANT
  end
end