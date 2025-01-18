<template>
  <div class="container">
    <row class="mt-4" justify-content="center">
      <h1 class="fs-7 fs-sm-up-9 fs-md-up-10">WORKS</h1>
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
              :key="p._path" 
              aspect-ratio="1 / 1"
              class="ma-2 hoverable of-hidden"
              :bg-image="p.image">
              <column justify-content="end" class="h-100">
                <card class="pa-2 el-0 bt bw-2 fw-medium" style="text-transform: uppercase;">
                  <div class="mt-1 of-visible">{{ p.title }}</div>
                </card>
                
                <!--card v-if="p.subtitle" class="pa-1 ma-1 el-0">
                  <div>{{ p.subtitle }}</div>
                </card-->
              </column>
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