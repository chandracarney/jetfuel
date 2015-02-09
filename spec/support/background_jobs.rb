module BackgroundJobs
  def run_background_jobs_immediately
    Resque.inline = true
    yield
    Resque.inline = false
  end
end
