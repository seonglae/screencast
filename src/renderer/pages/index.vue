<template>
  <v-app>
    <v-app-bar app id="bar" class="top">
      <v-app-bar-title class="headline text-uppercase">
        <span>Screen</span>
        <span class="font-weight-light">cast</span>
      </v-app-bar-title>
      <v-spacer />

      <v-btn v-on:click="github" class="mr-2">
        Github
      </v-btn>
      <v-btn v-on:click="() => remote.app.exit(0)" class="blue-grey darken-3">
        Exit
      </v-btn>
    </v-app-bar>

    <templates-run class="wrapper" />
  </v-app>
</template>

<script lang="ts">
import { defineComponent, ref } from '@vue/composition-api'
import { shell, remote } from 'electron'
import pkg from '../../../package.json'

export default defineComponent({
  name: 'index',
  setup() {
    const github = () => shell.openExternal(pkg.repository)
    const index = ref(0)

    return { github, remote, index }
  }
})
</script>

<style src="~/assets/toast.css" />
