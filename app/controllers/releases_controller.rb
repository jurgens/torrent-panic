class ReleasesController < ApplicationController
  def show
    release = Release.find params[:id]
    @release = Releases::Presenter.new(release)
    @movie = release.movie
  end
end
