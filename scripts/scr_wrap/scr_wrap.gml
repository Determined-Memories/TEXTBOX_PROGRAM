function scr_wrap(value, _min, _max) // I'm not going to find my one rn, so this one it is
{
	if ((value % 1) == 0)
	{
		while (value > _max || value < _min)
		{
			if (value > _max)
			{
				value = (_min + value) - _max - 1
			}
			else if (value < _min)
			{
				value = ((_max + value) - _min) + 1
			}
			else
			{
			}
		}
		
		return value;
	}
	else
	{
		var _old = argument[0] + 1
		
		while (value != _old)
		{
			_old = value
			
			if (value < _min)
			{
				value = _max - (_min - value)
			}
			else if (value > _max)
			{
				value = _min + (value - _max)
			}
			else
			{
			}
		}
		
		return value;
	}
}
