class StepController < ApplicationController

  STEPS = ['Introduction',
            'What is Ruby?',
            'What is Rails?',
            'News websites', 'Reddit', 'HackerNews', 'You are not alone',
            'Sites for finding help', 'StackOverflow',
            'Sites for learning',
            'Register in GitHub',
            'Shuhari',
            'Shu',
              'Ruby interactive lessons',
              'Ruby koans',
              'Rails interactive lessons',
              'git interactive lesson',
              'gems',
              'bundler',
              'fork this!',
              'Rspec interactive lessons',
              'run the tests',
              'run in your localhost',
              'upload it to heroku',
            'Ha',
              'first spec change',
              'commit your change',
              'style change',
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
  STEP_IDS = STEPS.map { |s| s.parameterize }

  def index
    redirect_to step_path(STEP_IDS.first)
  end

  def step
    @step_id = params.require(:step)
    @step_n = STEP_IDS.index(@step_id)
    redirect_to :finished and return if @step_n.nil?
    @step = partial_name(@step_n)
    @step_name = STEPS[@step_n]
    @next = STEP_IDS[@step_n+1]

    if !step_exists(@step_n)
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
    STEPS[step_n].gsub(' ', '_').gsub('?','').downcase
  end
  helper_method :partial_name

end
