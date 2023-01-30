<script setup lang="ts">
import type { ApexOptions } from 'apexcharts'
import { generateDayWiseTimeSeries } from '~~/utils/data.generate'

const props = defineProps<{
	width?: number
	height?: number
	data: number[][]
}>()

const theme = useColorMode()
const labelColor = computed(() => (theme.value === 'dark' ? '#fff' : '#000'))

const series = computed(() => [
	{
		name: 'Total Transactions',
		data: generateDayWiseTimeSeries(props.data[0]),
	},
	{
		name: 'Flagged Transactions',
		data: generateDayWiseTimeSeries(props.data[1]),
	},
])

const options = computed<ApexOptions>(() => {
	return {
		chart: {
			toolbar: {
				show: false,
			},
			width: props.width,
		},
		colors: ['#00E396', '#0090FF'],
		stroke: {
			curve: 'smooth',
			width: 3,
		},
		dataLabels: {
			enabled: false,
		},
		markers: {
			size: 0,
			strokeColors: '#fff',
			strokeWidth: 3,
			strokeOpacity: 1,
			fillOpacity: 1,
			hover: {
				size: 6,
			},
		},
		xaxis: {
			type: 'datetime',
			tooltip: {
				enabled: false,
			},
			labels: {
				style: {
					colors: labelColor.value,
					fontFamily: 'ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, Liberation Mono, Courier New, monospace',
				},
				format: 'dd/MM',
			},
		},
		yaxis: {
			labels: {
				style: {
					colors: labelColor.value,
					fontFamily: 'ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, Liberation Mono, Courier New, monospace',
				},
			},
		},
		legend: {
			show: false,
		},
		fill: {
			type: 'solid',
			opacity: 0.7,
		},
		grid: {
			xaxis: {
				lines: {
					show: false,
				},
			},
			yaxis: {
				lines: {
					show: false,
				},
			},
			padding: {
				left: 16,
				right: 0,
			},
		},
		tooltip: {
			theme: theme.value,
			style: {
				fontFamily: 'ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, Liberation Mono, Courier New, monospace',
			},
			cssClass: 'apexcharts-tooltip',
		},
	}
})
</script>

<template>
	<ClientOnly>
		<apexchart
			type="area"
			:series="series"
			:options="options"
		/>
	</ClientOnly>
</template>

<style scoped>

</style>
