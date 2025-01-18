<template>
  <div>
  <column style="height: 100dvh; position: relative;" class="container" justify-content="space-between">
    <column justify-content="end" class="mt-3 mx-2">
      <row class="mt-2" justify-content="end">
        <card>
          <card-text>
            <ContentRenderer class="ta-end of-visible"  :value="imprint">
            </ContentRenderer>

          </card-text>
        </card>
      </row>
      <row class="mt-2" justify-content="end">
        <btn class="ml-2 mb-2" icon="mdiGithub" to="https://github.com/meksor" target="_blank">
          Github
        </btn>
        <btn class="ml-2 mb-2" icon="mdiEarth" to="https://iiasa.ac.at/staff/maximilian-wolschlager" target="_blank">
          IIASA
        </btn>
      </row>
    </column>
    <row justify-content="end" align-items="end" class="mb-4 mx-2">
      <!--btn to="/gallery/" icon="mdiArtboard" class="mr-2">
        GALLERY
      </btn-->
      <btn to="/works/" icon="mdiGrid" class="fs-5 bw-4">
        WORKS
      </btn>
    </row>
  </column>
  <row class="my-4 container" justify-content="middle">
    <card>
      <card-text>
        <ContentRenderer class="ta-end of-visible" :value="legal">
        </ContentRenderer>


      </card-text>
    </card>
</row>

</div>
</template>


<script setup lang="ts">
const img = useImage()
definePageMeta({
    title: 'Max Wolschlager',

})
useSeoMeta({
    title: 'Max Wolschlager',
    description: 'Programmer, Artist',
    ogDescription: 'Programmer, Artist',
    ogImage: img("/img/fallback.png"),
    twitterCard: 'summary_large_image',
})
const { data: imprint } = await useAsyncData('imprint', () => {
  return queryCollection('content').path('imprint').first()
})
const { data: legal } = await useAsyncData('legal', () => {
  return queryCollection('content').path('legal').first()
})
</script>

<style lang="scss">
.main-menu {
  position: absolute;
  bottom: 0;
  left: 0;
}
</style>
