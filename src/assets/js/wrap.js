import baseURL from './baseURL'

export default {
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
    return baseURL + 'uploads/images/' + ur;
  }
}
