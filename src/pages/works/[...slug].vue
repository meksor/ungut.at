<template>
  <div>
    <div class="container pa-2 mt-3">
      <btn :to="backPath" icon="mdiArrowLeft">
        Back
      </btn>
    </div>
    <article class="container">
      <card v-if="doc" class="ma-2 el-2">
        <card-text >
          <doc-header :doc="doc"></doc-header>
        </card-text>
        <nuxt-img class="header__image" fit="cover" :src="doc.headerImage" width="100%"></nuxt-img>
        <card-text>
          <ContentRenderer class="body-text" :value="doc">
            <template #empty>
              Nothing here...
            </template>

          </ContentRenderer>
        </card-text>
        <divider />
        <card-text >
          <doc-signature :date="doc.date"></doc-signature>
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
const { data: doc } : any = await useAsyncData(`content:${route.path}`, () => queryContent(route.path).findOne())

definePageMeta({ 
  layout: 'works',
}) 

useSeoMeta({
    title: doc?.title,
    description: doc?.subtitle,
    ogDescription: doc?.subtitle,
    ogImage: img(doc?.image),
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