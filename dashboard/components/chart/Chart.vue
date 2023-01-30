<script setup lang="ts">
defineProps<{
	width: number
}>()

const options = {
	chart: {
		toolbar: {
			show: false,
		},
	},
	colors: ['#00E396', '#0090FF'],
	stroke: {
		curve: 'smooth',
		width: 3,
	},
	dataLabels: {
		enabled: false,
	},
	series: [{
		name: 'Total Views',
		data: generateDayWiseTimeSeries(0, 18),
	}, {
		name: 'Unique Views',
		data: generateDayWiseTimeSeries(1, 18),
	}],
	markers: {
		size: 0,
		strokeColor: '#fff',
		strokeWidth: 3,
		strokeOpacity: 1,
		fillOpacity: 1,
		hover: {
			size: 6,
		},
	},
	xaxis: {
		type: 'datetime',
		axisBorder: {
			show: false,
		},
		axisTicks: {
			show: false,
		},
	},
	yaxis: {
		labels: {
			offsetX: 14,
			offsetY: -5,
		},
		tooltip: {
			enabled: true,
		},
	},
	tooltip: {
		x: {
			format: 'dd MMM yyyy',
		},
	},
	legend: {
		show: false,
	},
	fill: {
		type: 'solid',
		fillOpacity: 0.7,
	},
}

function generateDayWiseTimeSeries(s: number, count: number) {
	const values = [[
		4, 3, 10, 9, 29, 19, 25, 9, 12, 7, 19, 5, 13, 9, 17, 2, 7, 5,
	], [
		2, 3, 8, 7, 22, 16, 23, 7, 11, 5, 12, 5, 10, 4, 15, 2, 6, 2,
	]]
	let i = 0
	const series = []
	let x = new Date('11 Nov 2012').getTime()
	while (i < count) {
		series.push([x, values[s][i]])
		x += 86400000
		i++
	}
	return series
}
</script>

<template>
	<ClientOnly class="w-full">
		<apexchart
			type="area"
			:width="width"
			:series="options.series"
			:options="options"
		/>
	</ClientOnly>
</template>

<style scoped>

</style>
