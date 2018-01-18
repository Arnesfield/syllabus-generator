<template>
<v-footer id="footer" absolute>
  <v-layout row wrap>
    <v-flex xs12 sm4 md3
      v-for="(item, i) in otherNav" :key="i"
      class="blue-grey darken-3 px-5 part">
      <h5 class="title mb-3 white--text">{{ item.title }}</h5>
      <nav-list :list="item.list"/>
    </v-flex>
    <v-flex xs12 md3
      class="blue-grey darken-2 px-5 part">
      <h5 class="title mb-3 white--text">Forge</h5>
      <nav-list :list="forge.list"/>
    </v-flex>
    <v-flex xs12 class="text-xs-center blue-grey darken-4 pa-3 white--text">
      <span class="blue-grey--text text--lighten-4" >
        &copy; {{ new Date().getFullYear() }}
        <pre class="blue-grey--text text--lighten-3" style="display: inline">&lt;/code&gt;</pre>.
        All rights reserved.
      </span>
    </v-flex>
  </v-layout>
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
      },
      {
        title: 'Heading',
        list: [
          { title: 'Link', link: '' },
          { title: 'Link', link: '' }
        ]
      },
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
  color: #cfd8dc;
  transition: 0.1s color;
}

#footer ul li a:hover,
#footer ul li a:focus {
  color: white;
}

#footer ul li a .icon {
  font-size: 18px;
  width: 24px;
}
</style>
