<template>
  <div class="container">
    <ContentDoc/>
    <ContentList path="/works/" v-slot="{ list }">
      <row class="my-4">
        <div v-for="p in list" class="w-100 w-half-sm-up w-third-md-up w-fourth-lg-up">
          <nuxt-link :to="p._path">
            <card
              :key="p._path" 
              aspect-ratio="1 / 1"
              class="ma-2 hoverable">

              <card class="pa-1 ma-1 el-0">
                <h2>{{ p.title }}</h2>
                <span>{{ p.subtitle }}</span>
              </card>
              <template #background>
                <nuxt-img class="w-100" :src="p.image"></nuxt-img>
              </template>
            </card>
          </nuxt-link>
        </div>

      </row>
    </ContentList>
  </div>
</template>

<script setup lang="ts">

definePageMeta({ 
  layout: 'works',
}) 

</script>