/* eslint-disable no-mixed-spaces-and-tabs */
import type { PropertiesSchema } from '@lyrasearch/lyra'

export { }

declare global {
    type Nullable<T> = T | null

    interface Schema extends PropertiesSchema {
    	_id: 'number'
    }
}
