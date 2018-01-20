<template>
<div>

<v-content>
  <v-parallax :src="require('@/assets/images/bg.jpg')">
    <v-container fluid fill-height>
      <v-layout wrap class="align-center text-xs-center">
        <v-flex>
          <h1 class="display-3 mb-2 white--text">Forge</h1>
          <div class="headline mb-3 white--text">Feutech Online Rundown Generator</div>
          <div class="mb-5">
            <span class="group pa-2">
              <v-btn class="mx-3" fab small color="white">
                <v-icon color="yellow">question_answer</v-icon>
              </v-btn>
              <v-btn class="mx-3" fab small color="white">
                <v-icon color="teal">build</v-icon>
              </v-btn>
              <v-btn class="mx-3" fab small color="white">
                <v-icon color="red">code</v-icon>
              </v-btn>
            </span>
          </div>
          <v-btn to="/login" class="mb-2 primary--text">Login</v-btn>
          <pre class="white--text">&lt;/code&gt;</pre>
        </v-flex>
      </v-layout>
    </v-container>
  </v-parallax>
</v-content>
<footer-view/>

</div>
</template>

<script>
import FooterView from '@/include/FooterView'

export default {
  name: 'home',
  components: {
    FooterView
  }
}
</script>
