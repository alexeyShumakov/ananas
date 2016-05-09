class HistorySerializer < ApplicationSerializer
  attributes :id, :title, :history, :history_md

  def history_md
    Kramdown::Document.new(object.history).to_html
  end
end
