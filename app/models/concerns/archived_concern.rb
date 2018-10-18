module ArchivedConcern
  extend ActiveSupport::Concern

  included do
    scope :archived, -> { where.not(:archived_on => nil) }
    scope :active,   -> { where(:archived_on => nil) }
  end

  def archived?
    !active?
  end

  def active?
    archived_on.nil?
  end
end
