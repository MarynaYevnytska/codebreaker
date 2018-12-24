FILE_NAME_SORT = '../sorting.yml'

module Storage
  def save(object, file_path)
    File.new(file_path, 'w+') unless File.exist?(file_path)
    File.open(file_path, 'a') { |file| file.write(YAML.dump(object)) }
  end

  def save_sorting(object, file_path)
    File.new(file_path, 'w+') unless File.exist?(file_path)
    File.open(file_path, 'w+') { |file| file.write(YAML.dump(object)) }
  end

  def load_settings(file_path)
    save_sorting(sorted(load_to_hash(file_path)).values, FILE_NAME_SORT)
    File.open(FILE_NAME_SORT, &:read)
  end

  def load_to_hash(file_path)
    YAML.load_documents(File.open(file_path))
  end

  def sorted(db)
    by_attemt = db.sort_by { |game| game[:attempts_used] }
    by_hint = by_attemt.sort_by { |game| game[:hints_used] }
    by_hint.group_by { |game| game[:difficulty] }
  end
end
