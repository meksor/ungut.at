<template>
  <div>
  <column style="height: 100dvh; position: relative;" class="container" justify-content="space-between">
    <column justify-content="end" class="mt-3 mx-2">
      <row class="mt-2" justify-content="end">
        <card>
          <card-text class="ta-end of-visible" >
            <p>
            <b>Max Wolschlager</b>
            </p>
            <p>
            public@ungut.at  
            </p>
            <p>
            Vienna, Austria  
            </p>
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
                
        The content on this website may
        be copyrighted. Get in touch if 
        you want to use it

        <br>

        This website contains links to other websites
        with content for which I am not responsible.
        § 17 ECG clears liability, as I have no knowledge
        of illegal activity on these sites and would 
        remove links to sites indulging in such if it 
        were to come to my attention.

        <!--ContentQuery path="/legal" find="one">
          <template #default="{ data: lData }">
            <ContentRenderer class="ta-end of-visible" :value="lData" />
          </template>
          <template #empty></template>
          <template #not-found></template>
        </ContentQuery-->
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
</script>

<style lang="scss">
.main-menu {
  position: absolute;
  bottom: 0;
  left: 0;
}
</style>
