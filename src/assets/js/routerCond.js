import storage from './storage'

export default function(router, http, bus) {

  const proceed = function(title, cAuth, next) {
    // if session is set and page needs auth
    let isSet = storage.get('isSet')
    if (isSet) {
      if (cAuth) {
        document.title = title
        next()
      } else {
        // goto dashboard
        router.push('dashboard')
      }
    } else {
      // if session is not set and page need not auth
      if (!cAuth) {
        document.title = title
      }
      next(!cAuth)
      // no goto login since it will be called on checkSession
    }
  }

  const checkSession = function(title, cAuth, next) {
    http.post('/sess').then(res => {
      // if session is not set
      if (!res.data.isset) {
        // clear session and go to component if need not auth
        storage.destroy()
        if (cAuth === false) {
          document.title = title
          next()
        } else {
          // go to login
          router.push('login')
        }
      } else {
        // if set
        storage.set({ isSet: true })
        bus.user = res.data.user
        proceed(title, cAuth, next)
      }
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

    // if error page
    if (cAuth === null) {
      document.title = title
      next()
      return
    }

    // check asynchronously when change page
    // update storage

    proceed(title, cAuth, next)
    checkSession(title, cAuth, next)
  })
}
