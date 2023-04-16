using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using NETWORK_ENGINE;

public class HighLevelEntity : NetworkComponent
{
    public float HP=100;
    public float OverShield=50;
    public float maxHP = 100;
    public float maxOverShield = 50;
    public float DamageScalar = 1;
    public float RegenTimer;
    public bool AProunds = false;
    public GameObject PlayerOvershield;

    //SFX required variables
    public PlayerAudioSFX AudioScript;
    public bool ShieldIsHit = false;
    public bool ShieldIsBroken = false;
    public bool HealthIsLow = false;
    public bool ShieldRegen = false;


    
    public void Damage(float DMGMod, bool piercing)
    {
        
        if (OverShield > 0 && !piercing)
        {
            OverShield=OverShield-(5*DMGMod);
            SendUpdate("SHIELD", OverShield.ToString());
            if (OverShield <= 0)
            {
                Debug.Log("Sendupdate for shieldbreak");
                SendUpdate("SHIELDBREAK", true.ToString());
            }
            if (this.GetComponent<NetworkPlayerController>().isSentry)
            {
                if(!this.GetComponent<SentryScript>().SentryPassive && this.GetComponent<NetworkPlayerController>().SuperCharge < this.GetComponent<NetworkPlayerController>().maxSuperCharge)
                {
                    this.GetComponent<NetworkPlayerController>().SuperCharge += 2;
                    SendUpdate("SCHARGE", this.GetComponent<NetworkPlayerController>().SuperCharge.ToString());
                }
            }
        }
        else
        {
            HP=HP-(5*DMGMod);
            SendUpdate("HP", HP.ToString());
        }
        RegenTimer = 5.0f;
    }
    public void trippedMine()
    {
        HP -= 50;
        RegenTimer = 5.0f;
       SendUpdate("HP", HP.ToString());
        
    }
    public void gotRailed()
    {
        OverShield = 0;
        HP = 0;
        SendUpdate("SHIELD",OverShield.ToString());
        SendUpdate("HP", HP.ToString());
    }
    public override void HandleMessage(string flag, string value)
    {
        if(IsClient && flag == "SHIELD")
        {
            OverShield=float.Parse(value);
            
        }
        if(IsClient && flag == "HP")
        {
            HP=float.Parse(value);
            
        }
        if(IsClient && flag == "SCHARGE")
        {
            this.GetComponent<NetworkPlayerController>().SuperCharge=int.Parse(value);
        }
        if(IsClient && flag == "SHIELDBREAK")
        {
            //will always tell client that ShieldIsBroken = true
            Debug.Log("Inside SHIELDBREAK HM");
            ShieldIsBroken = true;
        }
    }

    public override void NetworkedStart()
    {
       
    }

    public override IEnumerator SlowUpdate()
    {
        yield return new WaitForSeconds(.1f);
    }

    // Start is called before the first frame update
    void Start()
    {
        AudioScript = this.GetComponent<PlayerAudioSFX>();

    }

    // Update is called once per frame
    public void Update()
    { 
        if(IsClient)
        {
            Debug.Log("If is client");
            if (this.OverShield <= 0)
            {
                Debug.Log("Overshield <= 0");
                //PlayerOvershield.SetActive(false);
                this.transform.GetChild(2).gameObject.SetActive(false);
            }
            else 
            {
                Debug.Log("Overshield > 0");
                //PlayerOvershield.SetActive(true);
                this.transform.GetChild(2).gameObject.SetActive(true);
            }
            Debug.Log("Shield is Broken = " + ShieldIsBroken);
            if (IsLocalPlayer && ShieldIsBroken)
            {
                ShieldIsBroken = false;
                Debug.Log("Shield is Broken");
                //Play Shield Broken SFX
                this.GetComponent<PlayerAudioSFX>().PlayShieldBreakAudio();
                Debug.Log("Playing OneShot");
            }
        }
    }
}
