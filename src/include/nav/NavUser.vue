<template>
  <div class="bg" style="background-image: url('./static/images/bg-2.sm.jpg')">
    <v-container fluid class="no-bg dim pa-3">
      <v-avatar class="accent elevation-6">
        <template v-if="imgSrc">
          <img v-if="imgSrc.isImg" :src="imgSrc.text" alt="avatar">
          <span v-else class="white--text headline">{{ imgSrc.text }}</span>
        </template>
        <template v-else>
          <span class="white--text headline">?</span>
        </template>
      </v-avatar>
    </v-container>
    <v-list class="no-bg dim">
      <v-list-tile>
        <v-list-tile-content>
          <v-list-tile-title class="title white--text">{{ fullname }}</v-list-tile-title>
          <v-list-tile-sub-title class="grey--text text--lighten-3">{{ username }}</v-list-tile-sub-title>
        </v-list-tile-content>
      </v-list-tile>
    </v-list>
  </div>
</template>

<script>
export default {
  name: 'nav-user',
  computed: {
    fullname() {
      let user = this.$bus.session.user
      return user && (user.fname || user.lname) ? user.fname + ' ' + user.lname : ''
    },
    username() {
      let user = this.$bus.session.user
      return user && user.username ? user.username : ''
    },
    imgSrc() {
      let user = this.$bus.session.user
      if (typeof user !== 'object' || user === null) {
        return null
      }
      if (typeof user.imgSrc !== 'string') {
        return {
          isImg: false,
          text: user.fname.charAt(0).toUpperCase()
        }
      } 
      return {
        isImg: true,
        text: user.imgSrc
      }
    }
  }
}
</script>
