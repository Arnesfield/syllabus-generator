module.exports = function(router, http) {
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

    // check for session
    http.post('/checkSession').then(res => {
      const id = res.data.id
      // if component does not need auth
      if (!cAuth) {
        if (!id) { document.title = title }
        // do not proceed if has id
        next(!id)
      }
      // must have id
      else if (id) {
        document.title = title
        next()
      } else {
        router.push('login')
      }
    }).catch(e => {
      next(false)
    })

  })

}
