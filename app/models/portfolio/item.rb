class Portfolio::Item < ActiveRecord::Base
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "150x150>" }
  validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  self.table_name = 'portfolio_items'

  has_many :social_links
  after_update :set_only_one_default

  private

  def set_only_one_default
    if self.default_changed? and self.default
      Portfolio::Item.where('id != ?', id).update_all(default: false)
    end
  end
end