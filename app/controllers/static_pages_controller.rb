# frozen_string_literal: true

# Controller for static pages
class StaticPagesController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  # welcome page
  def index; end

  # home page
  def home; end

  # help page
  def help; end

  # about page
  def about; end

  # contact page
  def contact; end
end
