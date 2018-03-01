<template>
<span>
  <!-- dark
  color="primary lighten-1"
  :gradient="gradient" -->
  <v-jumbotron
    height="100%"
  >
    <v-container fill-height>
      <v-layout align-center>
        <v-flex>
          <h3 class="display-3">Forge</h3>
          <v-divider class="my-3"/>
          <div class="subheading mb-3 mono">&lt;/code&gt;</div>
          <v-btn
            large
            to="/login"
            class="mx-0"
            color="primary"
            v-text="'Login'"
          />
        </v-flex>
      </v-layout>
    </v-container>
  </v-jumbotron>
</span>
</template>

<script>
export default {
  name: 'home',
  data: () => ({
    gradient: 'to right, #008349, #319e61'
  })
}
</script>
