module ArchivedConcern
  extend ActiveSupport::Concern

  included do
    scope :archived, -> { where.not(:source_deleted_at => nil) }
    scope :active,   -> { where(:source_deleted_at => nil) }
  end

  def archived?
    !active?
  end

  def active?
    source_deleted_at.nil?
  end
end
