json.array! @bookmark_practices do |practice|
  json.work_slug practice.chapter.work.slug
  json.extract! practice, :id, :name, :enabled, :requires_auth
  json.bookmarked true
end
