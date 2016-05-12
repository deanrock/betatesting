# Allow ".zip" as an extension for files with the MIME type "application/octet-stream".
Paperclip.options[:content_type_mappings] = {
    :ipa => "application/zip"
}