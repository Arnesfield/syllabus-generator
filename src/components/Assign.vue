<template>
<v-container v-bind="{ ['grid-list-' + size]: true }">
  <template v-for="(t, i) in type" v-if="countAssigns(t.n)">
    <v-subheader :key="'subheader-' + i">{{ t.title }}</v-subheader>
    <v-layout :key="'layout-' + i" row wrap>
      <v-flex
        md4
        lg3
        xs12
        sm6
        :key="i"
        v-for="(assign, i) in assigns"
        v-if="Number(assign.status) == t.n"
      >
        <assign-inst :assign='assign'/>
      </v-flex>
    </v-layout>
  </template>
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
    size: 'lg',
    type: [
      { title: 'Approved', n: 1 },
      { title: 'Undecided', n: 2 },
      { title: 'Not yet submitted', n: 3 },
      { title: 'Denied', n: 0 }
    ],
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
    countAssigns(n) {
      // check assigns with status n
      // return the length
      return this.assigns.filter(e => Number(e.status) == n).length
    },

    fetch() {
      this.loading = true
      this.$http.post(this.url).then((res) => {
        console.error(res.data)
        if (!res.data.success) {
          throw new Error('Request failure.')
        }
        
        this.assigns = res.data.assigns
        this.loading = false
      }).catch(e => {
        console.error(e)
        this.loading = false
      })
    }
  }
}
</script>
