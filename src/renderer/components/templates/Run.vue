<template>
  <div class="flex" text-center>
    <div class="main" text-center>
      <h1 class="display-2 font-weight-bold mb-3">Screencast</h1>
      <svg v-on:click="make" class="liquid-button" />
    </div>
  </div>
</template>

<script lang="ts">
import { run } from 'node-cmd'
import { defineComponent, onMounted, ref } from '@vue/composition-api'
import { useStore } from '@nuxtjs/composition-api'
import { resolve } from 'path'
import { remote } from 'electron'
import DancingButton from 'dancing-button'
import { promises } from 'fs'

import useToast from '~/composables/useToast'

import type { Store } from 'vuex'
import type { State } from '~/store/'

const AHK_PATH = 'resources\\ahk\\exe\\ahk\\AutoHotkey.exe'
const MAKER_PATH = 'resources\\ahk\\make.ahk'

const exists = async path => await promises.stat(path).catch(() => false)

export default defineComponent({
  setup(_, context) {
    const store: Store<State> = useStore()
    const toast = useToast(context.root)
    const running = ref(false)

    // Run Command
    async function make() {
      if (running.value) return
      running.value = true
      const root = resolve(remote.app.getAppPath(), '../../')
      const ahkPath = resolve(root, AHK_PATH)
      const makePath = resolve(root, MAKER_PATH)
      store.state.loading = true
      const exist = (await exists(ahkPath)) && (await exists(makePath))
      if (!exist) return toast.error('No File')
      run(`"${ahkPath}" "${makePath}"`, () => {
        console.log('done')
        remote.app.exit(0)
        console.log('done')
      })
    }

    onMounted(() => {
      const button = document.querySelector('.liquid-button')
      new DancingButton(button)
    })
    return { make }
  }
})
</script>
