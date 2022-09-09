class AddDateSubmitted < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :date_submitted, :datetime
  end
end
