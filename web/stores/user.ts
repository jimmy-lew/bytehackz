import { defineStore } from 'pinia'

export const useUserStore = defineStore('user', () => {
	const user = ref<Account>(null)
	const setUser = (currentUser: Account) => user.value = currentUser

	return {
		user,
		setUser,
	}
})
