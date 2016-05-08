class HistorySerializer < ApplicationSerializer
  attributes :id, :name, :email, :history, :history_md

  def history_md
    Kramdown::Document.new(object.history).to_html
  end
end
