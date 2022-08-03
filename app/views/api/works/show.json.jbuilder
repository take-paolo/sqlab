json.extract! @work, :id, :name, :slug, :description

json.chapters do
  json.array! @chapters do |chapter|
    if chapter.practices.present?
      json.extract! chapter, :id, :name
      json.practices do
        json.array! chapter.practices, :id, :name, :enabled, :requires_auth
      end
    end
  end
end
