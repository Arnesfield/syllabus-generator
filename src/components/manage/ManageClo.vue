<template>
<v-container fluid>

  <template v-for="(item, i) in items">
    <manage-clo-inst
      :key="i"
      v-model="items[i]"
      class="mb-2"
      @edit="editItem"
    />
  </template>

</v-container>
</template>

<script>
import qs from 'qs'
import ManageCloInst from '@/include/ManageCloInst'

export default {
  name: 'manage-clo',
  components: {
    ManageCloInst
  },
  data: () => ({
    url: '/outcomes',
    items: [],
    limit: 30,
    loading: false,
    search: null
  }),

  watch: {
    loading(e) {
      this.$bus.refresh(e)
    }
  },

  created() {
    this.fetch()
  },

  methods: {
    editItem(item) {
      // edit item here
    },

    fetch() {
      this.loading = true
      this.$http.post(this.url, qs.stringify({
        detailed: true,
        search: this.search,
        limit: this.limit
      })).then(res => {
        console.warn(res.data)
        if (!res.data.success) {
          throw new Error('Request failure.')
        }

        this.loading = false
        this.items = res.data.outcomes
      }).catch(e => {
        console.error(e)
        this.loading = false
      })
    }
  }
}
</script>
