<template>
  <div class="container">
    <row class="mt-4" justify-content="center">
      <h1 class="fs-6 fs-sm-up-7 fs-md-up-8">WORKS</h1>
      <ContentDoc>
        <template #empty>
        </template>
      </ContentDoc>
    </row>
    <row class="my-4">
      <ContentQuery path="/works/" :sort="sortBy" v-slot="{data: works}">
        <div v-for="p in works" class="w-100 w-half-sm-up w-third-md-up w-fifth-lg-up">
          <nuxt-link :to="p._path">
            <card
              :key="p._path + '/'" 
              aspect-ratio="1 / 1"
              class="ma-2 hoverable">
              <column justify-content="space-between" class="h-100">
                <card class="pa-1 ma-1 el-0">
                  <h2>{{ p.title }}</h2>
                </card>
                <card class="pa-1 ma-1 el-0">
                  <div>{{ p.subtitle }}</div>
                </card>
              </column>
              <template #background>
                <nuxt-img class="w-100" :src="p.image"></nuxt-img>
              </template>
            </card>
          </nuxt-link>
        </div>
      </ContentQuery>
    </row>
  </div>
</template>

<script setup lang="ts">
const sortBy = ref({ date: -1 })

definePageMeta({ 
  layout: 'works',
}) 

</script>