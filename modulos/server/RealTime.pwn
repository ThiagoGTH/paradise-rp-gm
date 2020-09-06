#include <a_samp>

new WeatherTimeCount;
new WeatherTimeChange = 3*1000*60*60; // a cada quanto tempo irá alterar o clima

OnTimerCheck()
{
	new h,m,s;
	gettime(h, m, s);
	SetWorldTime(h);
	//
	if(WeatherTimeCount < GetTickCount())
	{
		WeatherTimeCount = GetTickCount() + WeatherTimeChange;
		//
		new RandomWeather = random(19);
		SetWeather(RandomWeather);
	}
}