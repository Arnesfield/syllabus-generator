<template>
<ul>
  <li :class="{ 'mb-2': i < list.length-1 }"
    v-for="(nav, i) in list" :key="i">
    <router-link class="subheading" v-if="!nav.external" :to="nav.link">
      <v-icon class="mr-2" dark v-if="nav.icon">{{ nav.icon }}</v-icon>{{ nav.title }}
    </router-link>
    <a class="subheading" target="_blank" v-else :href="nav.link">
      <v-icon class="mr-2" dark v-if="nav.icon">{{ nav.icon }}</v-icon>{{ nav.title }}
    </a>
  </li>
</ul>
</template>

<script>
export default {
  name: 'nav-list',
  props: {
    list: {
      type: Array,
      required: true
    }
  }
}
</script>
