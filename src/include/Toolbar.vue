<template>
  <v-toolbar
    app
    dark
    :clipped-left="$bus.nav.clipped"
    color="primary"
  >
    <v-toolbar-side-icon @click.stop="$bus.nav.model = !$bus.nav.model"></v-toolbar-side-icon>

    <v-tooltip bottom>
      <v-btn
        icon
        tabindex="1"
        slot="activator"
        :ripple="false"
        @click.stop="$bus.nav.miniVariant = !$bus.nav.miniVariant">
        <v-icon v-html="$bus.nav.miniVariant ? 'chevron_right' : 'chevron_left'"/>
      </v-btn>
      <span>{{ $bus.nav.miniVariant ? 'Expand' : 'Collapse' }}</span>
    </v-tooltip>

    <v-toolbar-title>Forge</v-toolbar-title>

  </v-toolbar>
</template>

<script>
export default {
  name: 'toolbar'
}
</script>
