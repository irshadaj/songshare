SimpleCov.start('rails') do
  add_filter 'app/assets'
  add_filter 'app/controllers'
  add_filter 'app/jobs/application_job.rb'
  add_filter 'app/views'
end