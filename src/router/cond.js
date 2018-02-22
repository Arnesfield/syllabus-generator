export default function(router, http, bus) {

  let beforeEach = function(to, from, next) {
    // set title
    const title = to.meta.title || to.name

    // do loading
    bus.progress.active = true

    // convert to array
    let toAuth = to.meta.auth
    if (typeof toAuth !== 'object') {
      toAuth = [toAuth]
    }
    let sessAuth = bus.session.auth
    if (typeof sessAuth !== 'object') {
      sessAuth = [sessAuth]
    }

    const nonauth = [0, 10]
    const auth = [1, 3, 4]

    const SESS_EXISTS = bus.authHas(sessAuth, auth)
    const TO_HAS_SESS = bus.authHas(toAuth, sessAuth, 10)
    const IS_ADMIN = bus.authHas(sessAuth, 1)
    const IS_FACULTY = bus.authHas(sessAuth, [3, 4])

    if (TO_HAS_SESS) {
      document.title = title
      next()
    } else {
      next(false)
      if (SESS_EXISTS) {
        if (IS_ADMIN) {
          router.push('/manage/users')
        } else if (IS_FACULTY) {
          router.push('/dashboard')
        }
      } else {
        router.push('/login')
      }
    }

    bus.progress.active = false
    return;

    // skip

    // no sess auth || nonauth to
    if (!bus.authCheck(to.meta.auth) || bus.authHas(to.meta.auth, [0, 10])) {
      bus.progress.active = false
      
      // go to login if user is not set
      if (bus.authHas(bus.session.auth, 0) || bus.authHas(to.meta.auth, 10)) {
        // if component is also 0 auth
        if (bus.authHas(to.meta.auth, [0, 10])) {
          document.title = title
          next()
          return
        }
        next(false)
        router.push('/login')
      }
      // if session auth but route not auth
      else if (bus.authHas(bus.session.auth, [1, 3, 4])) {
        // if component is also >= 3 auth
        // component should be greater than or equal to session auth
        if (bus.authCheck(to.meta.auth)) {
          document.title = title
          next()
          return
        }
        next(false)
        // go to manage users if auth is admin
        if (bus.authHas(bus.session.auth, 1)) {
          router.push('/manage/users')
        } else {
          router.push('/dashboard')
        }
      }
      return
    }
    
    document.title = title
    next()
    // stop loading
    bus.progress.active = false
  }

  bus.$on('watch--session.auth', (route) => {
    beforeEach(route, null, (e) => {})
  })

  router.beforeEach((to, from, next) => {
    // check for session
    bus.sessionCheck(to, http)
    beforeEach(to, from, next)
  })
}
