<template>
<v-card
  :dark="dark"
  :light="light"
  ripple
  hover
  height="100%"
  class="smooth-bg-and-shadow text-xs-center"
>
  <v-layout
    justify-center
    align-center
    class="full-height"
  >
    <div>
      <v-layout
        :style="{
          height: selected ? '64px' : '0px'
        }"
        align-center
        justify-center
        style="overflow: hidden"
        class="smooth-height"
        :class="{ 'mb-2': selected }"
      >
        <v-icon
          dark
          size="64px"
        >check_circle</v-icon>
      </v-layout>
      <slot name="title"/>
      <v-layout
        align-center
        justify-center
        :class="{ 'mb-1': selected }"
      >
        <div
          :style="{
            width: selected ? '100%' : '0px',
            'border-bottom': selected ? '5px solid white' : 'none'
          }"
          class="smooth-width"
        />
      </v-layout>
      <slot name="subtitle"/>
    </div>
  </v-layout>
</v-card>
</template>

<script>
export default {
  name: 'version-card',
  props: {
    light: {
      type: Boolean,
      default: false
    },
    dark: {
      type: Boolean,
      default: false
    },
    selected: Boolean
  }
}
</script>
