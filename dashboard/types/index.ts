/* eslint-disable no-mixed-spaces-and-tabs */
import type { PropertiesSchema } from '@lyrasearch/lyra'

export { }

declare global {
    type Nullable<T> = T | null

    type SizeTypes = 'none' | 'sm' | 'md' | 'lg' | 'xl' | '2xl' | '3xl' | 'full'
    type RoundTypes = SizeTypes

    interface Schema extends PropertiesSchema {
    	_id: 'number'
    }

    interface DateRangeItem {
    	_id: number
    	date: string
    	value: string
    }
}
