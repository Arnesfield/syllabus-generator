<template>
<v-select
  v-model="tags"
  :label="label"
  :placeholder="placeholder"
  :color="color"
  chips
  tags
  deletable-chips
  autocomplete
  :disabled="disabled"
  :search-input.sync="search"
  prepend-icon="label"
  :loading="loading"
  :items="items"
  @update:searchInput="fetch"
  :required="required"
  :rules="[ (required ? $fRule('requiredArray') : () => true) ]"
/>
</template>

<script>
import qs from 'qs'
import debounce from 'lodash/debounce'

export default {
  name: 'select-tags',
  props: {
    value: Array,
    label: {
      type: String,
      default: 'Tags'
    },
    placeholder: {
      type: String,
      default: undefined
    },
    color: {
      type: String,
      default: 'primary'
    },
    disabled: Boolean,
    required: {
      type: Boolean,
      default: false
    }
  },
  data: () => ({
    url: '/tags',
    search: null,
    tags: [],
    items: [],
    loading: false
  }),
  watch: {
    tags(to, from) {
      this.$emit('input', to)
    },
    value(e) {
      this.tags = e
    },
    search(e) {
      e && this.fetch(e)
    }
  },
  created() {
    this.tags = this.value
  },

  methods: {
    fetch: debounce(function(e) {
      const search = this.search
      if (!search) {
        return
      }

      this.loading = true
      this.$http.post(this.url, qs.stringify({
        search: search
      })).then((res) => {
        if (!res.data.success) {
          throw new Error('Request failure.')
        }
        this.loading = false
        this.items = res.data.tags
      }).catch(e => {
        console.error(e)
        this.loading = false
      })
    })
  }
}
</script>
