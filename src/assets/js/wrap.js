const monthNames = [
  'January', 'February', 'March',
  'April', 'May', 'June',
  'July', 'August', 'September',
  'October', 'November', 'December'
]
const leadZero = (num) => (num < 10 ? '0' : '') + num
const shortMonth = (month) => month.substring(0, 3)

export default {
  date(e, showSeconds) {
    if (typeof showSeconds !== 'boolean') {
      showSeconds = true
    }

    let date = new Date(e * 1000)

    let year = date.getFullYear()
    let month = shortMonth(monthNames[date.getMonth()])
    let day = leadZero(date.getDay())
    let hours = leadZero(date.getHours())
    let mins = leadZero(date.getMinutes())
    let secs = leadZero(date.getSeconds())

    return month + ' ' + day + ', ' + year + ' ' + hours + ':' + mins +
      (showSeconds ? ':' + secs : '')
  },

  fullname(user, mname) {
    if (typeof user !== 'object') {
      return ''
    }
    if (typeof mname !== 'boolean') {
      mname = true
    }
    
    let fullname = user.fname + ' '
    fullname += mname && user.mname ? user.mname + ' ' : ''
    fullname += user.lname

    return fullname
  }
}
