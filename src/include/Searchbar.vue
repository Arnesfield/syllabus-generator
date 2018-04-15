<template>
<v-text-field
  flat
  :dark="dark"
  :solo="solo"
  :solo-inverted="soloInverted"
  prepend-icon="search"
  :append-icon="input ? 'close' : undefined"
  :append-icon-cb="clearInput"
  :loading="loading"
  :label="label"
  v-model="input"
  @keypress.enter="search('enter')"
/>
</template>

<script>
import debounce from 'lodash/debounce'

export default {
  name: 'searchbar',
  props: {
    dark: {
      type: Boolean,
      default: false
    },
    solo: {
      type: Boolean,
      default: false
    },
    soloInverted: {
      type: Boolean,
      default: true
    },
    label: {
      type: String,
      default: 'Search'
    }
  },
  data: () => ({
    input: null,
    loading: false
  }),
  watch: {
    loading(e) {
      this.$bus.refresh(e)
    },
    $route(to, from) {
      // only clear if to and from not dashboard
      // if (to.name !== 'Dashboard' && from.name !== 'Dashboard') {
      //   this.clearInput()
      // }
    },
    '$bus.search.input': function(e) {
      this.input = e
    },
    input(e) {
      // show progress when in dashboard only
      // if (this.$route.name === 'Dashboard') {
      //   this.$bus.refresh(true)
      // }
      this.loading = true
      this.$bus.search.input = e
      this.search()
    }
  },
  created() {
    this.input = this.$bus.search.input
  },

  methods: {
    clearInput() {
      if (this.input) {
        this.input = null
        this.$bus.search.input = null
      }
    },
    search: debounce(function(e) {
      if (typeof e !== 'string') {
        e = 'input'
      }

      // only search if input search exists
      if (!this.input) {
        // nevermind lol
        // return
      }

      // go to dashboard on enter search
      // if (e === 'enter' && this.$route.name !== 'Dashboard') {
      //   this.$router.push('/dashboard')
      // }

      // emit search
      this.loading = false
      this.$bus.$emit('search', this.input)
    }, 500)
  }
}
</script>
