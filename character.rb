require "./message_dialog"

class Character
  # 小クラスのBrave、MonsterクラスでMessageDialogモジュールを使うためのインクルード
  include MessageDialog

  attr_reader :offense, :defense
  attr_accessor :hp, :name

  def initialize(**params)
    @name = params[:name]
    @hp = params[:hp]
    @offense = params[:offense]
    @defense = params[:defense]
  end
end