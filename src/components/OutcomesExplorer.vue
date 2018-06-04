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
      xs12 sm6 md4
      v-for="(item, i) in items"
    >
      <manage-outcome-inst
        v-model="items[i]"
        report
        class="pa-2"
        @select="selectItem"
        :is-selected="isSelected(i)"
      />
    </v-flex>
  </v-layout>

  <sidenav-outcomes :items="list"/>

</v-container>
</template>

<script>
import qs from 'qs'
import find from 'lodash/find'
import remove from 'lodash/remove'
import SidenavOutcomes from '@/include/SidenavOutcomes'
import ManageOutcomeInst from '@/include/ManageOutcomeInst'

export default {
  name: 'report-outcomes',
  components: {
    SidenavOutcomes,
    ManageOutcomeInst
  },
  data: () => ({
    url: '/outcomes',
    items: [],
    limit: 30,
    loading: false,
    search: null,
    list: []
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
  },
  beforeDestroy() {
    this.$bus.$off('refresh--btn', this.fetch)
  },

  mounted() {
    if (this.$refs.searchbar) {
      this.$nextTick(this.$refs.searchbar.focus)
    }
  },

  methods: {
    fetch() {
      this.loading = true
      this.$http.post(this.url, qs.stringify({
        strict: true,
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
    },

    selectItem(item) {
      // add this item to an array
      let existing = Boolean(find(this.list, { id: item.id }))
      if (existing) {
        // remove item
        
      } else {
        this.list.push(item)
      }
    },

    isSelected(i) {
      // check if item is in list
      let item = this.items[i]
      return Boolean(find(this.list, { id: item.id }))
    }
  }
}
</script>
