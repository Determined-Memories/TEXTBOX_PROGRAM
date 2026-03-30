function scr_getsavedir(fname){
	var tempprofix = ".textboxprogramtempdirget"
	var fname_temp = string(fname) + tempprofix
	var f = file_text_open_write(fname_temp)
	file_text_write_string(f, "A")
	file_text_close(f)
	var array = string_split_ext(string(fname), ["/", "\\"], true)
	var path = filename_path(fname_temp) + array[array_length(array) - 1]
	file_delete(fname_temp)
	var preferedpath = environment_get_variable("LOCALAPPDATA") + "\\DELTARUNE\\TEXTBOX_PROGRAM\\"
	return string_replace(path, game_save_id, preferedpath)
}