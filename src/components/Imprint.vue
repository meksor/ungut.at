<template>
  <div class="imprint body-bold">
    <div>
      Maximilian Wolschlager <br>
      rxtx@ungut.at <br>
      Vienna, Austria <br>
      <br>
      Max Wolschlager e.U. <br>
      Company Registry Number: 508478m <br>
      Company Registry Court: Handelsgericht Wien <br>
      GLN: 9110027226954 <br>
      Government Authority: Magistrat der Stadt Wien <br>
      <br>
    </div>
    <div>
      The content on this website may
      be copyrighted. Get in touch if 
      you want to use it. <br>
      <br>
      This website contains links to other websites
      with content for which I am not responsible.
      § 17 ECG clears liability, as I have no knowledge
      of illegal activity on these sites and would 
      remove links to sites indulging in such if it
      were to come to my attention. <br>
    </div>
  </div>
</template>


<style lang="scss">
@import '@/assets/scss/variables.scss';

.imprint {
    color: map-get($shades, 'white');
    padding: map-get($spacing, 'xl');
    display: flex;
    flex-direction: column;
    justify-content:space-between;
    div {
      flex: 1;
      max-width: 700px;
    }
}
</style>