// The Deltarune team used https://github.com/sidfishgames/swayingtext/blob/master/scr_wave.txt and modified it
function scr_wave(from, to, duration, duriationmult = 1) {
	var a4 = (to - from) * 0.5
	return from + a4 + (sin(( ((current_time * 0.001) + (duration * duriationmult)) / duration) * (2 * pi)) * a4);
}