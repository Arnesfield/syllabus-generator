export default {
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
