  const pay = () => {
    Payjp.setPublicKey("pk_test_1ff00993f7ce93b4058fdec7"); // PAY.JPテスト公開鍵
    const form = document.getElementById("charge-form");
    form.addEventListener("submit", (e) => {
      e.preventDefault();
      
      const formResult = document.getElementById("charge-form");
    const formData = new FormData(formResult);

    const card = {
      number: formData.get("buy_address[card_number]"),
      cvc: formData.get("buy_address[card_cvc]"),
      exp_month: formData.get("buy_address[card_exp_month]"),
      exp_year: `20${formData.get("buy_address[card_exp_year]")}`,
    };

    Payjp.createToken(card, (status, response) => {
      if (status == 200) {
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} name='token' type="hidden"> `;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
      }

      document.getElementById("card-number").removeAttribute("name");
      document.getElementById("card-cvc").removeAttribute("name");
      document.getElementById("card-exp-month").removeAttribute("name");
      document.getElementById("card-exp-year").removeAttribute("name");

      console.log(card);

      document.getElementById("charge-form").submit();

    });
    });
  };
;
  
  window.addEventListener("load", pay);