class RemoveFieldFromProducer < ActiveRecord::Migration
  def change
    remove_column :producers, :image_url, :string
  end
end
