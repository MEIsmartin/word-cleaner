class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :title
      t.text :original
      t.text :cleaned

      t.timestamps
    end
  end
end
