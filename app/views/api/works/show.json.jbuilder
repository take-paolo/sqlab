json.extract! @work, :id, :name, :slug, :description

json.chapters do
  json.array! @chapters do |chapter|
    if chapter.practices.present?
      json.extract! chapter, :id, :name
      json.practices do
        json.array! chapter.practices do |practice|
          json.extract! practice, :id, :name, :enabled, :requires_auth
          json.bookmarked practice.bookmarked_by?(current_user) if current_user
        end
      end
    end
  end
end
