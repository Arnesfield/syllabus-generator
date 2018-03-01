import monthNames from './months'

const leadZero = (num) => (num < 10 ? '0' : '') + num
const shortMonth = (month) => month.substring(0, 3)

let _date = function(e, short) {
  short = typeof short === 'boolean' ? short : true

  let date = new Date((Number(e)/*  + 24*60*60 */) * 1000)

  let year = date.getFullYear()
  let temp = monthNames[date.getMonth()]
  let month = short ? shortMonth(temp) : temp
  let day = leadZero(date.getDate())
  
  return month + ' ' + day + ', ' + year
}

let _time = function(e, showSeconds) {
  showSeconds = typeof showSeconds === 'boolean' ? showSeconds : true

  let date = new Date((Number(e)/*  + 24*60*60 */) * 1000)

  let hours = leadZero(date.getHours())
  let mins = leadZero(date.getMinutes())
  let secs = leadZero(date.getSeconds())

  return hours + ':' + mins + (showSeconds ? ':' + secs : '')
}

export default {
  date: (e, short) => _date(e, short),
  time: (e, showSeconds) => _time(e, showSeconds),
  datetime(e, short, showSeconds) {
    let date = _date(e, short)
    let time = _time(e, showSeconds)
    return date + ' ' + time
  },

  status(e) {
    const status = {
      0: 'Disapproved',
      1: 'Approved',
      2: 'Undecided',
      3: 'Not yet submitted'
    }
    
    return status[e]
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
  },
  localImg(url) {
    // change this
    return 'http://localhost/xforge/public/uploads/images/' + url
  }
}
