class HistorySerializer < ApplicationSerializer
  attributes :id, :title, :history, :history_md
  has_one :user

  def history_md
    Kramdown::Document.new(object.history).to_html
  end
end
