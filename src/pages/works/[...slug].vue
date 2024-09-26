<template>
  <div>
    <div class="container pa-2 mt-3">
      <btn :to="backPath">
        <mdi-icon icon="mdiArrowLeft" class="mr-2"/>
        Back
      </btn>
    </div>
    <article class="container">
      <card class="ma-2 el-2">
        <card-text>
          <doc-header :doc="doc"></doc-header>
        </card-text>
        <nuxt-img fit="cover" :src="doc.headerImage" class="header__image w-100 h-100"></nuxt-img>
        <card-text>
          <ContentRenderer class="body-text" :value="doc">
            <template #empty>
              Nothing here...
            </template>

          </ContentRenderer>
        </card-text>
      </card>
    </article>
  </div>  
</template>


<script setup lang="ts">
const route = useRoute();
const router = useRouter();
const backPath = computed(() => router.options.history.state.back as string ?? "/works");
const { data: doc } = await useAsyncData(`content:${route.path}`, () => queryContent(route.path).findOne())

definePageMeta({ 
  layout: 'works',
}) 

</script>

<style lang="scss">
.header__image {
  max-height: 450px;
  border-top: 2px outset var(--color-black);
  border-bottom: 2px outset var(--color-black);
}
.body-text {
  overflow: visible;
}
.body-text > * {
  overflow: visible;
  margin-bottom: 1rem !important;
}
.body-text > h2 > a {
  text-decoration: none;
  color: var(--color-black);
}

</style>