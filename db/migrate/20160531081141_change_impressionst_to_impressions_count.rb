class ChangeImpressionstToImpressionsCount < ActiveRecord::Migration
  def change
    rename_column :posts, :impressions, :impressions_count
  end
end
