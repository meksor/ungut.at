<template>
  <div>
    <div class="container pa-2 mt-3">
      <btn :to="backPath" icon="mdiArrowLeft">
        Back
      </btn>
    </div>
    <article class="container">
      <card v-if="page" class="ma-2 el-2">
        <card-text >
          <doc-header :doc="page"></doc-header>
        </card-text>
        <nuxt-img class="header__image" fit="cover" :src="page.headerImage" width="100%"></nuxt-img>
        <card-text>
          <ContentRenderer class="body-text" :value="page">
            <template #empty>
              Nothing here...
            </template>

          </ContentRenderer>
        </card-text>
        <divider />
        <card-text >
          <doc-signature :date="page.date"></doc-signature>
        </card-text>
      </card>
    </article>
  </div>  
</template>

<script setup lang="ts">
const img = useImage();
const route = useRoute();
const router = useRouter();
const backPath = computed(() => router.options.history.state.back as string ?? "/works/");
const { data: page } = await useAsyncData(route.path, () => {
  return queryCollection('content').path(route.path).first()
})

definePageMeta({ 
  layout: 'works',
}) 

useSeoMeta({
    title: page.value?.title,
    description: page.value?.subtitle,
    ogDescription: page.value?.subtitle,
    ogImage: img(page.value?.image),
    twitterCard: 'summary_large_image',
})
</script>

<style lang="scss">
.header__image {
  overflow: hidden;
  border-top: 2px outset var(--color-black);
  border-bottom: 2px outset var(--color-black);
  width: 100%;
}
.body-text {
  overflow: visible;
}
.body-text > * {
  margin-bottom: 1rem !important;
}
.body-text > h2 > a {
  text-decoration: none;
  color: var(--color-black);
}
</style>