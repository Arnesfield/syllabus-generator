<template>
<v-container fluid grid-list-lg>

  <v-container class="py-0">
    <v-text-field
      solo
      label="Search outcome"
      prepend-icon="search"
      :append-icon="search ? 'close' : undefined"
      :append-icon-cb="() => { search ? search = null : null }"
      class="mb-4"
      ref="searchbar"
      v-model="search"
    />
  </v-container>

  <v-layout row wrap>
    <v-flex
      :key="i"
      xs12 sm6 md4 lg3
      v-for="(item, i) in items"
    >
      <manage-outcome-inst
        v-model="items[i]"
        class="pa-2"
        @select="editItem"
      />
    </v-flex>
  </v-layout>

  <dialog-manage-outcome ref="dialog"/>

</v-container>
</template>

<script>
import qs from 'qs'
import ManageOutcomeInst from '@/include/ManageOutcomeInst'
import DialogManageOutcome from '@/include/dialogs/DialogManageOutcome'

export default {
  name: 'manage-outcomes',
  components: {
    ManageOutcomeInst,
    DialogManageOutcome
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
    },
    search(e) {
      this.fetch()
    }
  },

  created() {
    this.fetch()
    this.$bus.$on('refresh--btn', this.fetch)
    this.$bus.$on('outcome--add', this.addItem)
    this.$bus.$on('manage--outcome.update', this.fetch)
  },
  beforeDestroy() {
    this.$bus.$off('refresh--btn', this.fetch)
    this.$bus.$off('outcome--add', this.addItem)
    this.$bus.$off('manage--outcome.update', this.fetch)
  },

  mounted() {
    if (this.$refs.searchbar) {
      this.$nextTick(this.$refs.searchbar.focus)
    }
  },

  methods: {
    editItem(item) {
      // edit item here
      if (this.$refs.dialog) {
        this.$refs.dialog.editItem(item)
      }
    },
    addItem(item) {
      if (this.$refs.dialog) {
        this.$refs.dialog.addItem()
      }
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
