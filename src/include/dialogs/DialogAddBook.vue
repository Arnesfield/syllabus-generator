<template>
<v-dialog
  v-model="$bus.dialog.ManageBooks.add"
  width="800"
  :overlay="false"
  :persistent="loading"
  transition="fade-transition"
  scrollable>
  <v-card>
    
    <!-- toolbar -->
    
    <v-toolbar dark color="primary">
      <v-btn
        icon
        dark
        :disabled="loading"
        @click.native="$bus.dialog.ManageBooks.add = false"
      >
        <v-icon>close</v-icon>
      </v-btn>
      <v-toolbar-title>Add Book</v-toolbar-title>
    </v-toolbar>

    <!-- end of toolbar -->
    
    <!-- content -->
    <v-card-text>

      <v-form ref="form" v-model="formValid">
        <v-text-field
          label="Citation"
          v-model="citation"
          required/>
        <v-switch
          :label="'Status: ' + (status ? 'Activated' : 'Deactivated')"
          v-model="status"/>
      </v-form>

    </v-card-text>

    <!-- end of content -->

    <v-card-actions class="pa-4 bg-dim">
      <template v-if="loading">
        <v-progress-circular
          indeterminate
          :active="loading"
          color="primary"
        />
        <span style="height: auto" class="subheader px-2">Loading...</span>
      </template>
      <v-spacer/>
      <v-btn
        flat
        tabindex="0"
        :disabled="loading"
        @click="clear"
      >Clear</v-btn>
      <v-btn
        color="primary"
        tabindex="0"
        :disabled="loading"
        @click="submit"
      >{{ mode }}</v-btn>
    </v-card-actions>

  </v-card>
</v-dialog>
</template>

<script>
import qs from 'qs'

export default {
  name: 'dialog-add-book',
  props: {
    mode: {
      type: String,
      default: 'Add'
    }
  },
  data: () => ({
    url: '/books/add',
    formValid: false,
    citation: null,
    status: true,
    loading: false
  }),

  methods: {
    submit() {
      if (this.$refs.form.validate()) {
        this.$http.post(this.url, qs.stringify({
          citation: this.citation,
          status: this.status ? 1 : 0
        })).then((res) => {
          if (!res.data.success) {
            throw new Error
          }
          this.$bus.dialog.ManageBooks.add = false
          this.$bus.$emit('snackbar--show', 'Added book successfully.')
          this.$bus.$emit('manage--books.update')
          this.clear()
        }).catch((e) => {
          console.error(e)
          this.$bus.$emit('snackbar--show', 'Cannot add book.')
        })
      }
    },
    clear() {
      this.$refs.form.reset()
      this.citation = null
      this.status = true
    }
  }
}
</script>
