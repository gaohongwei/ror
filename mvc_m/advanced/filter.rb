Filter
  https://ducktypelabs.com/four-ways-to-filter-has_many-associations/
  User.joins(:projects).where(projects: { zipcode: 30332 })
  User.joins(:projects).merge(Project.opened_recently)
  User.joins(:projects).merge(Project.opened_recently).uniq

  User.includes(:projects).where(projects: { zipcode: '30332' })
  User.includes(:projects).merge(Project.opened_recently).references(:projects)


Filter in association
  class Gif < ApplicationRecord
    has_one :ranking
    has_many :upvotes,   -> { upvotes   }, class_name: "Vote"
    has_many :downvotes, -> { downvotes }, class_name: "Vote"

    scope :with_votes,    -> { includes(:upvotes, :downvotes) }
    scope :with_rankings, -> { includes(:ranking) }
    scope :order_by_rank, -> { joins(:ranking).order('rankings.rank', 'rankings.id') }

    delegate :rank, to: :ranking

    def downvotes_count
      downvotes.size
    end

    def upvotes_count
      upvotes.size
    end
  end

  class Vote < ApplicationRecord
    belongs_to :gif

    scope :upvotes,   -> { where(value:  1) }
    scope :downvotes, -> { where(value: -1) }
  end

  class Ranking < ApplicationRecord
    self.primary_key = :id

    belongs_to :gif
  end
