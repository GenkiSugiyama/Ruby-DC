# メッセージ出力をモジュールにまとめる
module MessageDialog
  def attack_message(**params)
    attack_type = params[:attack_type]

    puts "#{@name}の攻撃"
    puts "必殺攻撃" if attack_type == "special_attack"
  end

  def damage_message(**params)
    target = params[:target]
    damage = params[:damage]

    puts <<~EOS

      #{target.name}は#{damage}のダメージを受けた
      #{target.name}の残りHPは#{target.hp}だ

    EOS
  end

  def end_message(result)
    if result[:brave_win_flag]
      puts <<~EOS

      勇者は勝った
      #{result[:exp]}の経験値と#{result[:gold]}のゴールドを手に入れた

      EOS
    else
      puts <<~EOS

      勇者は負けた
      目の前が真っ暗になった

      EOS
    end
  end
end