# frozen_string_literal: true

module Api
  class BookmarksController < BaseController
    before_action :require_login

    def index
      @bookmark_practices = current_user.bookmark_practices.includes(chapter: :work)

      render 'index', formats: :json, handlers: 'jbuilder'
    end

    def create
      practice = Practice.find(params[:practice_id])
      current_user.bookmark(practice)
    end

    def destroy
      practice = Practice.find(params[:id])
      current_user.unbookmark(practice)
    end
  end
end
