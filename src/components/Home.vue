<template>
<div class="full-height" v-scroll="onScroll" id="top">

  <v-toolbar
    dark
    fixed
    class="full-width"
    :class="{
      [toolbarElevation]: true
    }"
    :color="toolbarColor"
  >
    <v-toolbar-title
      @click="toolbarClick"
      class="clickable pt-3x"
    >
      <v-avatar
        size="32px"
        class="mr-1"
        style="background-color: none"
      >
        <img src="/static/images/logo.png"/>
      </v-avatar>
      <span>Forge</span>
    </v-toolbar-title>

    <v-spacer/>
    <v-toolbar-items>
      <v-btn
        flat
        class="hidden-sm-and-down"
        @click="$vuetify.goTo('#features', options)"
      >Features</v-btn>
      <v-btn flat to="/login">
        <span class="mr-2">Login</span>
        <v-icon>exit_to_app</v-icon>
      </v-btn>
    </v-toolbar-items>
  </v-toolbar>

  <v-jumbotron
    height="688"
    :gradient="gradient"
    class="pa-0 white"
  >
    <v-parallax
      class="pa-0"
      height="688"
      style="position: relative;"
      src="./static/images/feu.jpg"
    >

      <v-container
        fluid
        grid-list-md
        style="background-color: rgba(0, 131, 73, 0.24)"
      >
        <v-layout>
          <v-flex xs2>
            <div class="box primary lighten-1"/>
          </v-flex>
          <v-flex xs1>
            <div class="box primary lighten-2"/>
          </v-flex>
          <v-flex xs5>
            <div class="box primary darken-1"/>
          </v-flex>
          <v-flex offset-xs1 xs2>
            <div class="box primary"/>
          </v-flex>
        </v-layout>

        <v-layout>
          <v-flex xs1>
            <div class="box primary darken-1"/>
          </v-flex>
          <v-flex xs4>
            <div class="box primary lighten-1"/>
          </v-flex>
          <v-flex offset-xs1 xs3>
            <div class="box primary"/>
          </v-flex>
          <v-flex xs1>
            <div class="box primary lighten-2"/>
          </v-flex>
        </v-layout>

        <v-layout>
          <v-flex offset-xs1 xs1>
            <div class="box primary lighten-1"/>
          </v-flex>
          <v-flex offset-xs1 xs2>
            <div class="box primary darken-1"/>
          </v-flex>
          <v-flex xs2>
            <div class="box primary"/>
          </v-flex>
          <v-flex xs1>
            <div class="box primary lighten-1"/>
          </v-flex>
        </v-layout>

        <v-layout>
          <v-flex offset-xs2 xs2>
            <div class="box primary lighten-1"/>
          </v-flex>
          <v-flex offset-xs1 xs1>
            <div class="box primary"/>
          </v-flex>
          <v-flex xs4>
            <div class="box primary darken-1"/>
          </v-flex>
          <v-flex xs2>
            <div class="box primary"/>
          </v-flex>
        </v-layout>

      </v-container>

      <div
        class="full-height full-width dim"
        style="position: absolute;"
      >
        <v-slide-y-reverse-transition>
          <v-container
            fill-height
            v-show="anim.title"
          >
            <v-layout
              row
              wrap
              align-center
              justify-center
            >
              <div>
                <h3 class="display-3">
                  <strong
                    class="mono"
                  >FORGE</strong>
                  <!-- <v-icon dark style="font-size: inherit">assignment</v-icon>
                  <v-icon dark style="font-size: inherit">school</v-icon>
                  <v-icon dark style="font-size: inherit">done_all</v-icon> -->
                </h3>
                <h6 class="title mt-1">
                  <template>FEUTECH Online</template>
                  <strong
                    class="white primary--text px-2 py-1"
                  >Rundown</strong>
                  <template>Generator</template>
                </h6>

                <!-- <v-divider class="mt-3 mb-2" dark/> -->

                <v-btn
                  to="/login"
                  color="warning"
                  large
                  class="mt-4"
                >Go to Login</v-btn>
              </div>
            </v-layout>
          </v-container>
        </v-slide-y-reverse-transition>
      </div>
    </v-parallax>
  </v-jumbotron>

  <!-- features -->

  <div class="py-5" id="features">
    <v-container
      grid-list-lg
      class="py-5 smooth-opacity"
      :style="{ opacity: featuresOpacity }"
    >

      <h3
        class="display-1 text-xs-center grey--text text--darken-1 mb-3"
      >Features</h3>

      <v-divider class="mb-3"/>

      <v-layout row wrap>
        
        <v-flex
          v-bind="{ [item.props]: true }"
          :key="i"
          v-for="(item, i) in features"
        >
          <v-card
            hover
            ripple
            class="clickable"
          >
            <v-card-media
              :src="item.src"
              height="320"
              class="feature-card-media"
              :class="item.color ? {
                [item.color]: true
              } : null"
              :style="item.rgb ? {
                'background-color': 'rgb(' + item.rgb + ')'
              } : null"
              style="position: relative"
            >
              <div
                class="full-width white--text"
                style="position: absolute; bottom: 0"
                :style="item.rgb ? {
                  'background-color': 'rgba(' + item.rgb + ', .5)'
                } : null"
              >
                <div style="background-color: rgba(0, 0, 0, 0.36)">
                  <v-card-title>
                    <div
                      v-text="item.title"
                      class="title text-xs-center full-width"
                    />
                  </v-card-title>
                  <v-card-text class="pt-0">
                    <div
                      v-text="item.text"
                      class="text-xs-center full-width"
                    />
                  </v-card-text>
                </div>
              </div>
            
            </v-card-media>
          </v-card>
        </v-flex>

      </v-layout>
    </v-container>
  </div>

  <!-- download -->

  <div>
    <v-jumbotron
      height="640"
      class="pa-0 white"
    >
      <v-parallax
        class="pa-0 download-bg smooth-opacity"
        height="640"
        :style="{ opacity: downloadOpacity }"
      >
        <v-container class="full-height">
          <v-layout align-center class="full-height">
            <div>
              <h2 class="display-2 primary--text mb-2">Download the App</h2>
              <h6 class="title primary--text text--lighten-1 mb-3">View syllabi on the go</h6>
              <div>
                <img class="clickable img-download" src="/static/images/getplaystore.png"/>
              </div>
            </div>
          </v-layout>
        </v-container>
      </v-parallax>
    </v-jumbotron>
  </div>

  <!-- footer -->

  <div class="primary py-5x white--text">

      <!-- height="688" -->
      <!-- height="688" -->
    <v-jumbotron
      :gradient="gradient"
      class="pa-0 white"
      height="auto"
    >
      <v-parallax
        class="pa-0"
        height="auto"
        style="position: relative;"
        src="./static/images/feu.jpg"
      >

        <v-container
          fluid
          grid-list-md
          style="background-color: rgba(0, 131, 73, 0.24)"
        >
          <v-layout>
            <v-flex offset-xs2 xs1>
              <div class="box primary lighten-1"/>
            </v-flex>
            <v-flex offset-xs1 xs3>
              <div class="box primary darken-1"/>
            </v-flex>
            <v-flex xs1>
              <div class="box primary lighten-2"/>
            </v-flex>
            <v-flex offset-xs1 xs2>
              <div class="box primary"/>
            </v-flex>
          </v-layout>

          <v-layout>
            <v-flex xs1>
              <div class="box primary darken-1"/>
            </v-flex>
            <v-flex xs4>
              <div class="box primary lighten-1"/>
            </v-flex>
            <v-flex offset-xs1 xs3>
              <div class="box primary"/>
            </v-flex>
            <v-flex xs1>
              <div class="box primary lighten-2"/>
            </v-flex>
          </v-layout>

        </v-container>

        <div
          class="full-height full-width dim"
          style="position: absolute;"
        >
          <v-slide-y-reverse-transition>
            <v-container
              fill-height
            >
              <v-layout
                row
                wrap
                align-center
                justify-center
              >
                <div>
                  <v-avatar
                    size="auto"
                    class="pa-2"
                    style="background-color: none;"
                  >
                    <img
                      src="/static/images/code.png"
                      style="width: 256px; height: auto"
                    />
                  </v-avatar>
                  <h3 class="headline text-xs-center mono">by &lt;/code&gt;</h3>
                </div>
              </v-layout>
            </v-container>
          </v-slide-y-reverse-transition>
        </div>
      </v-parallax>
    </v-jumbotron>
  </div>

  <v-footer
    dark
    :height="null"
    color="primary darken-1"
  >
    <v-container class="mono">
      <v-layout
        row
        wrap
        class="primary--text text--lighten-4 caption"
        align-center
      >
        <v-flex
          justify-center
          align-center
        >Copyright &copy; {{ $autoYear }} &lt;/code&gt;</v-flex>
        <v-flex
          justify-center
          align-center
          text-sm-right
        >FORGE Web and Mobile Application</v-flex>
      </v-layout>
    </v-container>
  </v-footer>

</div>
</template>

<script>
export default {
  name: 'home',
  data: () => ({
    gradient: 'to right, #008349, #319e61',
    options: {
      duration: 800,
      offset: -64,
      easing: 'easeInOutCubic'
    },
    scrollOffset: 0,
    anim: {
      title: false
    },
    shift: {
      toolbar: 560,
      download: 1440,
      features: 300
    },

    features: [
      {
        title: 'Generator',
        text: 'Create a syllabus with existing content suggestions.',
        src: '/static/images/generator.png',
        props: 'xs12 sm6 md6 lg8',
        rgb: '38, 166, 154'
      },
      {
        title: 'Versioning',
        text: 'Preserving content of older syllabus versions.',
        src: '/static/images/versioning.png',
        props: 'xs12 sm6 md6 lg4',
        rgb: '180, 224, 224'
      },
      {
        title: 'Hierarchy of Approval',
        text: 'Reach the consensus of users before approving.',
        src: '/static/images/hierarchy.png',
        props: 'xs12 sm6 md6 lg5',
        rgb: '255, 64, 129'
      },
      {
        title: 'Central Repository',
        text: 'Provides a repository for all syllabus content.',
        src: '/static/images/database.png',
        props: 'xs12 sm6 md6 lg7',
        rgb: '224, 224, 224'
      },
      {
        title: 'Course Mapping',
        text: 'Mapping of courses to other related courses.',
        src: '/static/images/mapping.png',
        props: 'xs12 sm6 md6 lg6',
        rgb: '171, 71, 188'
      },
      {
        title: 'Course Tree',
        text: 'Creates a tree to show prerequisite and corequisite courses.',
        src: '/static/images/tree.png',
        props: 'xs12 sm6 md6 lg6',
        rgb: '255, 235, 59'
      }
    ]
  }),

  computed: {
    toolbarElevation() {
      return this.scrollOffset < this.shift.toolbar ? 'elevation-0' : ''
    },
    toolbarColor() {
      return this.scrollOffset < this.shift.toolbar ? 'transparent' : 'primary'
    },
    featuresOpacity() {
      return this.scrollOffset > this.shift.features ? 1 : 0
    },
    downloadOpacity() {
      return this.scrollOffset > this.shift.download ? 1 : 0
    },
  },

  created() {
    this.onScroll()
  },

  mounted() {
    setTimeout(() => {
      this.anim.title = true
    }, 500)
  },

  methods: {
    onScroll(e) {
      this.scrollOffset = window.pageYOffset || document.documentElement.scrollTop
    },
    toolbarClick() {
      this.$vuetify.goTo('#top', {
        duration: 800,
        offset: 0,
        easing: 'easeInOutCubic'
      })
    }
  }
}
</script>

<style scoped>
.box {
  height: 164px;
  opacity: 0.72;
}

.download-bg {
  background-image: url('/static/images/download.png');
  background-size: 18%;
  background-position: 75% 50%;
}

.img-download {
  width: 128px;
}
</style>
