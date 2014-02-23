class StepController < ApplicationController

  def index
    redirect_to step_path(1)
  end

  def step
    step_n = params.require(:step).to_i
    @step = partial_name(step_n)
    @next = step_n+1
    if step_n > 100
      redirect_to :finished
    elsif !step_exists(step_n)
      render :missing
    end
  end

  def finished; end

  private

  def step_exists(step_n)
    lookup_context.template_exists?(partial_name(step_n), 'step', true)
  end
  helper_method :step_exists

  def partial_name(step_n)
    "step_#{step_n}"
  end

end
