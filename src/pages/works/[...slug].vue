<template>
  <ContentDoc v-slot="{ doc }" >
    <article class="container">
      <card class="ma-2">
        <card-text>
          <h1>{{ doc.title }}</h1>
          <div>{{ doc.subtitle }}</div>
          <divider class="my-1"/>
          <div><strong>{{ displayDate(doc) }}</strong></div>
        </card-text>
        <nuxt-img fit="cover" :src="doc.headerImage" class="header__image w-100 h-100"></nuxt-img>
        <card-text >
          <ContentRenderer class="body-text" :value="doc" />
        </card-text>
      </card>
    </article>
  </ContentDoc>  
</template>


<script setup lang="ts">

definePageMeta({ 
  layout: 'works',
}) 


const displayDate = (doc: any) => {
  return new Date(Date.parse(doc.date)).toDateString()
}

</script>

<style lang="scss">
.header__image {
  max-height: 450px;
}
.body-text > * {
  margin-bottom: 1rem !important;
}
.body-text > h2 > a {
  text-decoration: none;
  color: var(--color-black);
}

</style>