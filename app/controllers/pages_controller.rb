class PagesController < ApplicationController
  layout 'application'
  def privacy_policy ; end

  def contact        ; end

  def statements     ; end

  def raise_error
    raise "Testing exception notification errors"
  end

end
