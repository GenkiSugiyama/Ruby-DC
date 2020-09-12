require './message_dialog'

class GamesController

  # MessageDialogモジュールのメソッドを利用するのでMessageDialogをインクルード
  include MessageDialog

  EXP_CONSTANT = 2
  GOLD_CONSTANT = 3

  def battle(**params)

    # 渡される勇者クラス、モンスタークラスをインスタンス変数に格納するbuild_characterメソッドを呼び出す
    build_characters(params)
    # loop doでループ処理
    loop do
      @brave.attack(@monster)
      break if battle_end?

      @monster.attack(@brave)
      break if battle_end?
    end

    battle_judgment

  end

  private

  def build_characters(**params)
    # インスタンス変数を定義しておくことで各メソッドで引数を取らず
    # インスタンス変数を使って処理がかける
    @brave = params[:brave]
    @monster = params[:monster]
  end

  def battle_end?
    @brave.hp <= 0 || @monster.hp <= 0
  end

  def brave_win?
    @brave.hp > 0
  end

  def battle_judgment
    result = caluclate_of_exp_and_gold

    end_message(result)
  end

  def caluclate_of_exp_and_gold
    if brave_win?
      brave_win_flag = true
      exp = (@monster.offense + @monster.defense) * EXP_CONSTANT # 経験値の計算に使用する定数
      gold = (@monster.offense + @monster.defense) * GOLD_CONSTANT # ゴールドの計算に使用する定数
    else
      brave_win_flag = false
      exp = 0
      gold = 0
    end

    {brave_win_flag: brave_win_flag, exp: exp, gold: gold}
  end

end