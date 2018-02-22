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
