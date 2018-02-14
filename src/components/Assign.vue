<template>
<v-container v-bind="{ ['grid-list-' + size]: true }">
  <v-layout row wrap>
    <v-flex
      md4
      lg3
      xs12
      sm6
      :key="i"
      v-for="(assign, i) in assigns"
    >
      <assign-inst :assign='assign'/>
    </v-flex>
  </v-layout>
</v-container>
</template>

<script>
import AssignInst from '@/include/assign/AssignInst'

export default {
  name: 'assign',
  components: {
    AssignInst
  },
  data: () => ({
    url: '/assigns',
    assigns: [],
    loading: false,
    size: 'lg'
  }),
  watch: {
    loading(to, from) {
      this.$bus.progress.circular.Assign.refresh = to
    }
  },

  created() {
    this.$bus.$on('assign--refresh', this.fetch)
    this.fetch()
  },

  methods: {
    fetch() {
      this.loading = true
      this.$http.post(this.url).then((res) => {
        console.error(res.data)
        if (!res.data.success) {
          throw new Error('Request failure.')
        }
        // parse all assigns
        this.assigns = res.data.assigns.map(e => {
          // e.content = JSON.parse(e.content)
          return e
        })

        this.loading = false
      }).catch(e => {
        console.error(e)
        this.loading = false
      })
    }
  }
}
</script>
