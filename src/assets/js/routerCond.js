import storage from './storage'

export default function(router, http) {

  var timeoutSet = false

  const expireTimer = function(endAt) {
    console.error(endAt - Date.now())
    timeoutSet = true
    setTimeout(function() {
      if (!timeoutSet || storage.get('loggedOut')) {
        // if is logged out, do not show expire message
        return
      }
      alert('Session expired')
      timeoutSet = false
      storage.destroy()
      router.push('login')
    }, endAt - Date.now())
  }

  const checkSession = function(title, cAuth, next, first) {
    // check for session
    http.post('/checkSession').then(res => {
      const setAt = res.data.setAt
      const endAt = res.data.endAt

      const isSet = setAt || endAt

      // if i need auth but is not set
      if (!isSet) {
        // destroy session if on load
        if (typeof first === 'boolean' && first === true) {
          timeoutSet = false
          storage.destroy()
        }
        // push if component needs auth
        if (cAuth) {
          router.push('login')
          return
        }
      } else {
        storage.set({ setAt: setAt, endAt: endAt })
        expireTimer(endAt)
      }

      // must have id
      document.title = title
      next()
    }).catch(e => {
      next(false)
    })

  }

  // router
  router.beforeEach((to, from, next) => {
    // set title
    const title = to.meta.title || to.name

    // check session, if component to needs authorization
    const cAuth = typeof to.meta.auth === 'undefined' ? true : to.meta.auth

    // make the request on refresh / page load
    window.onload = function() {
      checkSession(title, cAuth, next, true)
    }

    // if error page
    if (cAuth === null) {
      document.title = title
      next()
      return
    }

    // if logged out, remove timeoutSet
    timeoutSet = typeof storage.get('loggedOut') !== 'undefined' && storage.get('loggedOut') === true
      ? false : timeoutSet

    if (timeoutSet) {
      // do not proceed if component need not auth
      if (!cAuth) {
        next(false)
      } else {
        document.title = title
        next()
      }
      return
    }
    
    // if timeoutSet is not set, check if endAt is set
    const endAt = storage.get('endAt')
    if (endAt) {
      // if set, set a expiration timer and set timeoutSet to true
      expireTimer(endAt)
      document.title = title
      next()
      return
    }

    // if component needs no auth, continue
    if (!cAuth) {
      document.title = title
      next()
      return
    }

    // below here if all cAuth = true
    checkSession(title, cAuth, next)
  })
  
}
