class Product < ActiveRecord::Base
  validates :title, :description,  presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: {
    with:    %r{\.(gif|jpg|png)\Z}i,
    message: "Must be a URL for GIF, JPG or PNG image."
  }

  scope :price_greater_than_hundread, -> {where(price: '100')}

  scope :latest_product, -> (limit) { order("created_at desc").limit(limit)}

  before_validation do
    puts "before_validation"
  end

  after_validation do
    puts "after_validation"
  end

  before_save do
    puts "before save num 1"    
     
  end  

  before_create do  
    puts "before create"
  end

  before_save do
    puts "before save no 2"
  end

  around_save :around_save

  around_create :around_create

  after_save do
    puts "after save"
  end

  after_create do
   puts "after create"
  end

  after_commit do
    puts "after commit"
  end

  before_update do
    puts "before update"
  end

  after_update do
    puts "after update"
  end

  before_destroy do
    puts "before destroy"
    # ggh*ghkjh
  end

  after_destroy do
    logger.info("#{self.title} has been destroyed")
    puts "after destroy"
  end

  after_touch do 
    puts "object has been touched"
  end

  after_rollback do
    logger.info("#{self.id} object failed to commit ")
  end

  after_initialize do
    puts "New object initialised"
  end

  after_find :find_record

  has_many :line_items
  has_many :orders, through: :line_items

  before_destroy :ensure_not_referenced_by_line_item

  def self.class_method(n)
    latest_product(n).first
  end


  def find_record
    begin
      logger.info("object found")
      puts "object located #{self.title}"      
    rescue Exception => e
      puts "sorry record not found"
    end
  end

  def ensure_not_referenced_by_line_item
  	if line_items.empty?
  		return true
  	else
  		errors.add(:base, 'Line Item Present')
  		return false
  	end
  end

  def around_save
    puts "in around save"
    yield
    puts "exiting around save"
  end

  def around_create
    puts "in around create"
    yield
    puts "exiting around create"
  end
end
