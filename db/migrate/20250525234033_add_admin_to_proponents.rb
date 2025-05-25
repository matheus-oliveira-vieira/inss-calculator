class AddAdminToProponents < ActiveRecord::Migration[8.0]
  def change
    add_column :proponents, :admin, :boolean, default: false
  end
end
