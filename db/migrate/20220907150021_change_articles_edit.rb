class ChangeArticlesEdit < ActiveRecord::Migration[7.0]
  def change
    change_column :articles, :edit_count, :integer, :default => 0
  end
end
