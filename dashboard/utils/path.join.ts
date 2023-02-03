export const getJointPaths = (pathSegments: string[]) => pathSegments
	.reduce((arr: string[], pathSeg: string, index: number) => index === 0 ? [pathSeg] : [...arr, `${arr[index - 1]}/${pathSeg}`], [])
