import { useState } from 'react'
import styled from 'styled-components'
import './App.css'
import { Stack, Grid } from '@mui/material'

const Container = styled.div`
  background-image: linear-gradient(205deg, black, grey 75%, grey 85%);
  align-items: ${props => (props.vcp ? "" : "center")};
  justify-content: center;
  --height: 100%;
  min-width: 100vw;
  display: flex;
  overflow: ${props => (props.vcp ? "show" : "hidden")};
`

const ButtonContainer = styled.div`
  align-items: center;
  justify-content: center;
  width: 50vw;
`

const Button = styled.button`
  min-width: 20wv;
  padding: 1.5vw;
  border-radius: 10vw;
  border: 2px solid rgba(255,255,255,0.2);
  color: white;
  background-color: transparent;
  animation: gradient 5s ease-in-out infinite;
  border-width: 5px;
  margin: 5vh 20vh;
`

const Header = styled.h1`
  color: #FFF;
  height: 100vh;
  width: 50vw;
  margin-top: 50%;
  padding-left: 20wv;
`

const EpochEntry = styled.div`
  min-width: 90vw;
  margin-left: 5vw;
  font-family: Inconsolata;
  color: grey;
  font-size: 32px;
  text-align: left;
`

const AlignText = styled.span`
  float: ${props => (props.right ? "right" : "left")}
`

const BigText = styled.h1`
  font-size: ${props => (props.type === 1) ? ("32px") : ((props.type === 2) ? ("42px") : ("58px"))};
  min-width: 100vw;
  font-family: Inconsolata;
  margin-top: 20vh;
`

const Divider = () => <hr style={{ borderBottom: 'none', borderTop: '1px solid grey' }} />;
const Claim = () => <button style={{ height: '24px', fontSize: '9px', marginLeft: '1vw', bottom: '2px' }}>Claim</button>;

export const truncateAddress = (address: string) => {
  address =
    address.substring(0, 12) +
    "..." +
    address.substring(address.length - 8, address.length);
  return address;
};


const PayoutListThreeColumns = ({ names, styles = null, title = "Signature", truncate = true }) => {
  return (<>

    <div style={styles}>
      <EpochEntry>
        <Grid container>
          <Grid item xs={4}>
            <b>{`${title}:`}</b>
          </Grid>
          <Grid item xs={4}>
            <b>Claimer Address:</b>
          </Grid>
          <Grid item xs={4}>
            <AlignText right><b>Payout:</b></AlignText>
          </Grid>
        </Grid>
      </EpochEntry>
      <Divider />
      {names.map((name, index) => {
        return (
          <div key={name.id}>
            <EpochEntry>
              <Grid container>
                <Grid item xs={4}>
                  <a href={`https://solscan.io/tx/{none}`} style={{textDecoration: 'none'}}>{truncate ? truncateAddress(name.name) : name.name}</a>
                </Grid>
                <Grid item xs={4}>
                  <a href={`https://solscan.io/`} style={{textDecoration: 'none'}}>{truncate ? truncateAddress(name.address) : name.address}</a>
                </Grid>
                <Grid item xs={4}>
                  <AlignText right>{name.balance}</AlignText>
                </Grid>
              </Grid>
            </EpochEntry>
            <Divider />
          </div>
        );
      })}
    </div>
  </>);
};

const PayoutList = ({ names, styles = null, title = "Signature", truncate = true }) => {
  return (<>

    <div style={styles}>
      <EpochEntry>
        <b>{`${title}:`}</b>
        <AlignText right><b>Payout:</b></AlignText>
      </EpochEntry>
      <Divider />
      {names.map((name, index) => {
        return (
          <div key={name.id}>
            <EpochEntry>
              <a href={`https://solscan.io/tx/{none}`} style={{textDecoration: 'none'}}>{truncate ? truncateAddress(name.name) : name.name}</a>
              <AlignText right>{name.balance}</AlignText>
            </EpochEntry>
            <Divider />
          </div>
        );
      })}
    </div>
  </>);
};

function One() {
  const names = [{
                  name: "CYtjKCg13VsSDp97AvtVPEdisiy3MNeUidir9gTmN1u5Wo1UEYGMf1oQhKPKmSgdhashdd4ifHShfF1WcThKmPL",
                  balance: "10 SOL"
                },{
                  name: "39xu876LTvcwvCAPPTy2Zd7gMz4qbgJC4yRm66k14ZbHqmvHTmKWRvMDN4MWd9mpbJ3BQqE7CD43fvdktZU2Mzw",
                  balance: "1.2K SOL"
                },{
                  name: "2Zg8w3VGnZgtKe8KwL9MEKoE6nyvq8tLShNvjSitXZpZyiV3bhFS7nCon1HN7WqZHpvZyhPAdDx3Ps7iA3j3Ju8P",
                  balance: "0.001 SOL"
                },{
                  name: "32Pfu1QVz6iotekQQUQAreji5f6LmKU1gdSzCxRo3STFYFBQ6869gbvWUAZ3oLUck77uL3jUVqBdy9jxVngm6mMd",
                  balance: "110 SOL"
                },{
                  name: "4KaTssqN4PbJXTNYRWvcGLV9uqbA2nGbD9pk2bhfyMEc4dZajZxZf5Giqy1o2CKgmMr9qow2WnXkuFn1yUuESNEq",
                  balance: "1 SOL"
                },{
                  name: "2nAdxegSmvmmcJx5RDfFLVmRbX292PufQaeLWZTuCbKhegzQ54QtXNjPRhizw6Dybb3rEozu2Pk4Qm4DDEu5oAes",
                  balance: "1.9M SOL"
                },{
                  name: "CYtjKCg13VsSDp97AvtVPEdisiy3MNeUidir9gTmN1u5Wo1UEYGMf1oQhKPKmSgdhashdd4ifHShfF1WcThKmPL",
                  balance: "10 SOL"
                },{
                  name: "39xu876LTvcwvCAPPTy2Zd7gMz4qbgJC4yRm66k14ZbHqmvHTmKWRvMDN4MWd9mpbJ3BQqE7CD43fvdktZU2Mzw",
                  balance: "1.2K SOL"
                },{
                  name: "2Zg8w3VGnZgtKe8KwL9MEKoE6nyvq8tLShNvjSitXZpZyiV3bhFS7nCon1HN7WqZHpvZyhPAdDx3Ps7iA3j3Ju8P",
                  balance: "0.001 SOL"
                },{
                  name: "32Pfu1QVz6iotekQQUQAreji5f6LmKU1gdSzCxRo3STFYFBQ6869gbvWUAZ3oLUck77uL3jUVqBdy9jxVngm6mMd",
                  balance: "110 SOL"
                },];
  return (
    <Container style={{
      minHeight: "100vh",
      background: "#000000"
    }} vcp>
      <Stack spacing={1}>
        <BigText type={1}>Payout History For address {"3NYeSL32aGTg2wnZk1kdLq85RiJ6UAqtPepduw7N9q1M"}</BigText>
        <BigText type={2} style={{paddingTop: '4vw'}}>Total Paid Out:</BigText>
        <BigText>100,000,000,000 SOL</BigText>
        <PayoutList names={names}/>
      </Stack>
    </Container>
  )
}

function Two() {
  const names = [{
                  name: "10",
                  balance: <span>10 SOL<Claim /></span>
                },{
                  name: "9",
                  balance: <span>1.2K SOL<Claim /></span>
                },{
                  name: "8",
                  balance: <span>0.001 SOL<Claim /></span>
                },{
                  name: "7",
                  balance: <span>110 SOL<Claim /></span>
                },{
                  name: "6",
                  balance: <span>1 SOL<Claim /></span>
                },{
                  name: "5",
                  balance: <span>1.9M SOL<Claim /></span>
                },{
                  name: "4",
                  balance: <span>10 SOL<Claim /></span>
                },{
                  name: "3",
                  balance: <span>1.2K SOL<Claim /></span>
                },{
                  name: "2",
                  balance: <span>0.001 SOL<Claim /></span>
                },{
                  name: "1",
                  balance: <span>110 SOL<Claim /></span>
                },];
  return (
    <Container style={{
      minHeight: "100vh",
      background: "#000000"
    }} vcp>
      <Stack spacing={1}>
        <BigText type={1}>Payout History For address {"3NYeSL32aGTg2wnZk1kdLq85RiJ6UAqtPepduw7N9q1M"}</BigText>
        <BigText type={2} style={{paddingTop: '4vw'}}>Total Paid Out:</BigText>
        <BigText>100,000,000,000 SOL</BigText>
        <PayoutList names={names} styles={{
          paddingTop: '1vh'
        }} title="Epoch" truncate={false}/>
      </Stack>
    </Container>
  )
}

function Three() {
  const names = [{
                  name: "CYtjKCg13VsSDp97AvtVPEdisiy3MNeUidir9gTmN1u5Wo1UEYGMf1oQhKPKmSgdhashdd4ifHShfF1WcThKmPL",
                  address: "85sibmfnTEhVrLcuNCE9qfwzzHFnTCZN4K82xFJZmhWr",
                  balance: "10 SOL"
                },{
                  name: "39xu876LTvcwvCAPPTy2Zd7gMz4qbgJC4yRm66k14ZbHqmvHTmKWRvMDN4MWd9mpbJ3BQqE7CD43fvdktZU2Mzw",
                  address: "BCTT6iARHrJs7Uv9CZ1VprQ1bhVBwt92gYr7DCXHTng1",
                  balance: "1.2K SOL"
                },{
                  name: "2Zg8w3VGnZgtKe8KwL9MEKoE6nyvq8tLShNvjSitXZpZyiV3bhFS7nCon1HN7WqZHpvZyhPAdDx3Ps7iA3j3Ju8P",
                  address: "93TUMPrvRG597RoZ5uNVbzPpwjo8nVpDB2JRzNzkX6t1",
                  balance: "0.001 SOL"
                },{
                  name: "32Pfu1QVz6iotekQQUQAreji5f6LmKU1gdSzCxRo3STFYFBQ6869gbvWUAZ3oLUck77uL3jUVqBdy9jxVngm6mMd",
                  address: "G7HcaakxJm1tixvKuH43dg8r6d9xBF8xfwTEaMvAog6",
                  balance: "110 SOL"
                },{
                  name: "4KaTssqN4PbJXTNYRWvcGLV9uqbA2nGbD9pk2bhfyMEc4dZajZxZf5Giqy1o2CKgmMr9qow2WnXkuFn1yUuESNEq",
                  address: "P73C2qHv73FizUF38hf2L9WFRWDiGZZLSHFLp3EuGU3",
                  balance: "1 SOL"
                },{
                  name: "2nAdxegSmvmmcJx5RDfFLVmRbX292PufQaeLWZTuCbKhegzQ54QtXNjPRhizw6Dybb3rEozu2Pk4Qm4DDEu5oAes",
                  address: "435pqE4hsnk2jphuSrRrZ4r9PRRBP9bQwm1oeXhtVtRr",
                  balance: "1.9M SOL"
                },{
                  name: "CYtjKCg13VsSDp97AvtVPEdisiy3MNeUidir9gTmN1u5Wo1UEYGMf1oQhKPKmSgdhashdd4ifHShfF1WcThKmPL",
                  address: "51m1rwW5Cea2YdKMk3US1vm6gEGZ73N4maceJNf7vRT4",
                  balance: "10 SOL"
                },{
                  name: "39xu876LTvcwvCAPPTy2Zd7gMz4qbgJC4yRm66k14ZbHqmvHTmKWRvMDN4MWd9mpbJ3BQqE7CD43fvdktZU2Mzw",
                  address: "BF5agLYRMRLi6bANvrWUEsuD9ikynnFbLTBWGD5S3eXV",
                  balance: "1.2K SOL"
                },{
                  name: "2Zg8w3VGnZgtKe8KwL9MEKoE6nyvq8tLShNvjSitXZpZyiV3bhFS7nCon1HN7WqZHpvZyhPAdDx3Ps7iA3j3Ju8P",
                  address: "EddXVq1bNadwR172n5qH6L8pRxRHCB182uHJLHk7Bfiy",
                  balance: "0.001 SOL"
                },{
                  name: "32Pfu1QVz6iotekQQUQAreji5f6LmKU1gdSzCxRo3STFYFBQ6869gbvWUAZ3oLUck77uL3jUVqBdy9jxVngm6mMd",
                  address: "7Yb1TMK2aFmFVzWARQwGwdEFPX5eVWgvFLueYtStz6F4",
                  balance: "110 SOL"
                },];
  return (
    <Container style={{
      minHeight: "100vh",
      background: "#000000"
    }} vcp>
      <Stack spacing={1}>
        <BigText type={1}>Payout History For address {"3NYeSL32aGTg2wnZk1kdLq85RiJ6UAqtPepduw7N9q1M"}</BigText>
        <BigText type={2} style={{paddingTop: '4vw'}}>Total Paid Out:</BigText>
        <BigText>100,000,000,000 SOL</BigText>
        <PayoutListThreeColumns names={names}/>
      </Stack>
    </Container>
  )
}

function App() {
  const [page, setPage] = useState(0);

  if (page === 1) {
    return <One />
  } else if (page === 2) {
    return <Two />
  } else if (page === 3 || page === 4) {
    return <Three />
  } else if (page === 0) {
    return (<>
      <Container>
        <Header>Choose which VCP model you want to simulate</Header>
        <ButtonContainer>
          <Button onClick={() => {
            setPage(1)
          }}>
            Gas Cost Solution #1
          </Button>
          <Button onClick={() => {
            setPage(2)
          }}>
            Gas Cost Solution #2
          </Button>
          <Button onClick={() => {
            setPage(3)
          }}>
            Gas Cost Solution #3
          </Button>
          <Button onClick={() => {
            setPage(4)
          }}>
            Gas Cost Solution #4
          </Button>
        </ButtonContainer>
      </Container>
    </>);
  }
}

export default App
