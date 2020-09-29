json.id @diary.id

json.title @diary.title
json.expiration @diary.expiration
json.kind @diary.kind

json.notes @diary.notes do |note|
    json.text note.text
end
