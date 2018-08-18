class Blog < ApplicationRecord
  # ---------------------Relations-------------------
  belongs_to :user

  # ----------------------ENUMS----------------------
  enum state: %i[drafted published]

  # ---------------------SCOPES----------------------
  scope :drafted, lambda {
    where(state: 'drafted')
  }

  scope :published, lambda {
    where(state: 'published')
  }
end
