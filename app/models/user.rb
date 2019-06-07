class User < ApplicationRecord
    has_many :attendances, dependent: :destroy
    attr_accessor :remember_token
    before_save { self.email = email.downcase }
    validates :name, presence: true, length: {maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: {maximum: 100},
                            format: { with: VALID_EMAIL_REGEX},
                            uniqueness: { case_sensitive: false}
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 },allow_nil: true
    validates :department, length: { in: 3..50 }, allow_blank: true
    validates :affiliation, length: { in: 3..50 }, allow_blank: true
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      # IDが見つかれば、レコードを呼び出し、見つかれなければ、新しく作成
      user = find_by(email: row["email"]) || new
      # CSVからデータを取得し、設定する
      user.attributes = row.to_hash.slice(*updatable_attributes)
      # 保存する
      user.save
    end
  end

  # 更新を許可するカラムを定義
  def self.updatable_attributes
    ["name", "email","affiliation","employee_number","uid","basic_work_time","designated_work_end_time",
    "designated_work_end_time","superior","admin","password"]
  end
    # 渡された文字列のハッシュ値を返す
    def self.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

  # ランダムなトークンを返す
  def self.new_token
    SecureRandom.urlsafe_base64
  end
   # 永続セッションのためにユーザーをデータベースに記憶する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  # ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end
    scope :get_by_name, ->(name) {
        where("name like ?", "%#{name}%")
    }
end
