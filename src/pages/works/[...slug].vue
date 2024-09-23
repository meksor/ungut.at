<template>
  <ContentDoc v-slot="{ doc }" >
    <article class="container">
      <card class="ma-2">
        <card-text>
          <h1>{{ doc.title }}</h1>
          <div>{{ doc.subtitle }}</div>
          <div>{{ doc.date }}</div>
        </card-text>
        <nuxt-img fit="cover" :src="doc.headerImage" class="header__image w-100 h-100"></nuxt-img>
        <card-text>
          <ContentRenderer :value="doc" />
        </card-text>
      </card>
    </article>
  </ContentDoc>  
</template>


<script setup lang="ts">

definePageMeta({ 
  layout: 'works',
}) 

</script>

<style lang="scss" scoped>
.header__image {
  max-height: 450px;
}
</style>