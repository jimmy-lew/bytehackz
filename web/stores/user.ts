import { defineStore } from 'pinia'

export const useUserStore = defineStore('user', () => {
	const user = ref<User>(null)
	const setUser = (currentUser: any) => user.value = currentUser

	return {
		user,
		setUser,
	}
})
