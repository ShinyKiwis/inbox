# frozen_string_literal: true

namespace :seed do
  desc 'Seed initial values for statues table'
  task statues: :environment do
    statues = [
      { name: 'published', description: 'Published for public view' },
      { name: 'private', description: 'Belongs to original owner only' },
      { name: 'shared', description: 'Shared for limited people only' },
      { name: 'pending_for_delete', description: 'Pending for delete or restore' },
    ]

    statues.each do |status_attributes|
      Status.find_or_create_by(status_attributes)
    end
  end
end
