export const generateDayWiseTimeSeries = (data: number[]) => {
	const time = new Date().getTime()
	const series = []

	for (let i = 0; i < data.length; i++) series.push([time - (86400000 * i), data[i]])

	return series
}
