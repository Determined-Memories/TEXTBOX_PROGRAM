function scr_wrap(value, _min, _max) {
	var __maxmod = (_max + 1 - _min)
	if __maxmod == 0 return 0
	value = value % __maxmod
	value = (_max - (_max - value) % __maxmod)
	return clamp(value, _min, _max)
}
