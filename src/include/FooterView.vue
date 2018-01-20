<template>
<v-footer
  app
  absolute
  inset
  color="white"
  :height="null"
  id="footer"
  style="height: auto">
  <v-container>
    <v-layout row wrap>
      <v-flex xs12 sm4
        v-for="(item, i) in otherNav" :key="i"
        class="px-5 part">
        <h5 class="title mb-3">{{ item.title }}</h5>
        <nav-list :list="item.list"/>
      </v-flex>
      <v-flex xs12 sm4
        class="px-5 part">
        <h5 class="title mb-3">Forge</h5>
        <nav-list :list="forge.list"/>
      </v-flex>
      <v-flex xs12 class="text-xs-center">
        <span class="grey--text text--darken-4" >
          &copy; {{ new Date().getFullYear() }}
          <pre class="grey--text text--darken-3" style="display: inline">&lt;/code&gt;</pre>.
          All rights reserved.
        </span>
      </v-flex>
    </v-layout>
  </v-container>
</v-footer>
</template>

<script>
import NavList from './footerView/NavList'

export default {
  name: 'footer-view',
  components: {
    NavList
  },
  data: () => ({
    otherNav: [
      {
        title: 'Heading',
        list: [
          { title: 'Link', link: '' },
          { title: 'Link', link: '' }
        ]
      },
      {
        title: 'Heading',
        list: [
          { title: 'Link', link: '' },
          { title: 'Link', link: '' }
        ]
      }
    ],
    forge: {
      list: [
        { title: 'Home', icon: 'fa-home', link: '/' },
        { title: 'Feutech', icon: 'fa-shield', link: 'http://www.feutech.edu.ph/', external: true },
        { title: 'Github', icon: 'fa-github', link: 'https://github.com/code-feutech', external: true },
        // { title: 'Facebook', icon: 'fa-facebook', link: '' },
        // { title: 'Twitter', icon: 'fa-twitter', link: '' }
      ]
    }
  })
}
</script>

<style>
#footer {
  display: block;
  height: auto;
}

#footer .part {
  padding-top: 32px;
  padding-bottom: 32px;
}

#footer ul {
  list-style-type: none;
}

#footer ul li a {
  text-decoration: none;
  color: #616161;
  transition: 0.1s color;
}

#footer ul li a:hover,
#footer ul li a:focus {
  color: #757575;
}

#footer ul li a .icon {
  width: 24px;
}
</style>
