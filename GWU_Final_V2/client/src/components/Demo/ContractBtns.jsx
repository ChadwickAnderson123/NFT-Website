import { useState } from "react";
import useEth from "../../contexts/EthContext/useEth";

// function ContractBtns({ setValue }) {
//  const { state: { contract, accounts } } = useEth();
//  const [inputValue, setInputValue] = useState("");

  function ContractBtns({ setValue }) {
    const { state: { contract, accounts } } = useEth();
    const [inputValue, setInputValue] = useState("");

  const handleInputChange = e => {
    if (/^\d+$|^$/.test(e.target.value)) {
      setInputValue(e.target.value);
    }
  };

  const mint = async () => {
    const value = await contract.methods.mint().send({ from: accounts[0] });
    setValue(value);
   };

   {/* const write = async e => {
    if (e.target.tagName === "INPUT") {
      return;
    }
    if (inputValue === "") {
      alert("Please enter a value to write.");
     return;
   }
    const newValue = parseInt(inputValue);
    await contract.methods.write(newValue).send({ from: accounts[0] });
  }; */}

  return (
    <div className="btns">

      {/* <button onClick={mint}>
        mint
      </button> */}

      {/* <button onClick={read}>
        read()
      </button> */}


      {/* Need to hook up inputs to mint function button */}
      <button onClick={mint}>
        <div onClick={mint} className="input-btn">
          mint(<input
            type="text"
            placeholder="uint"
            value={inputValue}
            onChange={handleInputChange}
          />)
        </div> 
      </button>
    </div>
  );
}

export default ContractBtns;
