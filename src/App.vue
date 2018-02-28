<template>
  <v-app :dark="$bus.settings.dark">
    <v-progress-linear
      color="warning"
      height="4"
      :active="$bus.progress.active"
      indeterminate
      style="z-index: 5; position: fixed"
      class="ma-0"
    />
    <navigation v-if="authCheck"/>
    <v-content>
      <toolbar-content v-if="authCheck"/>
      <router-view/>
      <fab/>
      <dialog-confirm/>
    </v-content>
    <toolbar v-if="authCheck"/>
    <snackbar/>
  </v-app>
</template>

<script>
import Navigation from '@/include/Navigation'
import Fab from '@/include/Fab'
import Toolbar from '@/include/Toolbar'
import ToolbarContent from '@/include/ToolbarContent'
import DialogConfirm from '@/include/dialogs/DialogConfirm'
import Snackbar from '@/include/Snackbar'

export default {
  name: 'App',
  components: {
    Navigation,
    Fab,
    Toolbar,
    ToolbarContent,
    DialogConfirm,
    Snackbar
  },
  computed: {
    authCheck() {
      return this.$bus.authCheck(this.$route.meta.auth)
    }
  },

  created() {
    this.$bus.$on('GET_ROUTE', (emit) => {
      this.$bus.$emit(emit, this.$route)
    })
  }
}
</script>
