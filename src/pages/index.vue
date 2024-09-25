<template>
  <column style="height: 100dvh; position: relative;" class="container" justify-content="space-between">
    <row justify-content="end" class="mt-3">
      <!--h1 class="fw-regular">ungut.at</h1-->
      <card>
        <card-text>
          <ContentDoc class="ta-end" path="/imprint" />
        </card-text>
      </card>

    </row>
    <row justify-content="space-between" align-items="end" class="mb-4">
      <btn to="/works/">WORKS</btn>
    </row>

    <!--row justify-content="center" class="w-100 ta-center mb-3">
      <nuxt-link to="/works/">
        <h1>WORKS</h1>
      </nuxt-link>
    </row-->
  </column>
</template>


<script setup lang="ts">

definePageMeta({ 
  documentDriven: { page: false, surround: false }
}) 

</script>

<style lang="scss">
.main-menu {
  position: absolute;
  bottom: 0;
  left: 0;
}
</style>
