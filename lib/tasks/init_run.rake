# frozen_string_literal: true

desc 'Initiate parser run'
task init_run: :environment do
  ParseHubRunner.run
end
