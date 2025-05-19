class CreateSummaries < ActiveRecord::Migration[7.1]
  def change
    create_table :summaries do |t|
      t.text :original
      t.text :result

      t.timestamps
    end
  end
end
