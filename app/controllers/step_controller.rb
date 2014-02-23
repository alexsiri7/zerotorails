class StepController < ApplicationController

  STEPS = ['introduction',
            'what is RoR?',
            'news websites', 'reddit', 'hackernews', 'joshuakemp',
            'sites for finding help', 'stackoverflow',
            'sites for learning', 'Rails casts',
            'Shuhari',
            'Shu',
              'Register in github',
              'Ruby koans',
              'ruby interactive lesson',
              'rails interactive lesson',
              'git interactive lesson',
              'gems',
              'bundler',
            'Ha',
              'fork this!',
              'run the tests',
              'run in your localhost',
              'first spec change',
              'commit your change',
              'style change',
              'upload it to heroku',
            'Ri',
              'First rails project: Dice Roller',
              'Get it working in git',
              'Roll dice',
              'Style with bootstrap',
              'Add user login',
              'Save the roll result in the database',
              'Show rolls for the user',
              'Show the scoreboard',
              'Upload to Heroku',
            'Where to now?']

  def index
    redirect_to step_path(0)
  end

  def step
    @step_n = params.require(:step).to_i
    @step = partial_name(@step_n)
    @step_name = STEPS[@step_n]
    @next = @step_n+1
    if @step_n > 100
      redirect_to :finished
    elsif !step_exists(@step_n)
      render :missing
    end
  end

  def finished; end

  private

  def step_exists(step_n)
    lookup_context.template_exists?(partial_name(step_n), 'step/steps', true)
  end
  helper_method :step_exists

  def partial_name(step_n)
    "#{STEPS[step_n].gsub(' ', '_')}"
  end

end
