class AddAttachmentAvatarToProducers < ActiveRecord::Migration
  def self.up
    change_table :producers do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :producers, :avatar
  end
end
