# frozen_string_literal: true

namespace :seed do
  desc 'Seed initial values for statues table'
  task statues: :environment do
    statues = [
      { name: 'published', status_type: 'privacy', description: 'Published for public view' },
      { name: 'private', status_type: 'privacy', description: 'Belongs to original owner only' },
      { name: 'shared', status_type: 'privacy', description: 'Shared for limited people only' },
      { name: 'pending_for_delete', status_type: 'operational', description: 'Pending for delete or restore' },
    ]

    statues.each do |status_attributes|
      Status.find_or_create_by(status_attributes)
    end
  end
end
