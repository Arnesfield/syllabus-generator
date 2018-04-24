const year = 2017
const now = (new Date()).getFullYear()

export default year === now ? year : year + '-' + now
