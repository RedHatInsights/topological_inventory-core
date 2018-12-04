module ArchivedConcern
  extend ActiveSupport::Concern

  included do
    scope :archived, -> { where.not(:archived_at => nil) }
    scope :active,   -> { where(:archived_at => nil) }
  end

  def archived?
    !active?
  end

  def active?
    archived_on.nil?
  end
end
