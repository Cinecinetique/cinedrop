json.array!(@scenes) do |scene|
  json.extract! scene, :project_id, :script_story, :script_video, :script_audio, :slugline, :position
  json.url scene_url(scene, format: :json)
end