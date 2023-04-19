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
    public GameObject TripMineEffect;

    
    public void Damage(float DMGMod, bool piercing)
    {
        
        if (OverShield > 0 && !piercing)
        {
            OverShield=OverShield-(5*DMGMod);
            SendUpdate("SHIELD", OverShield.ToString());
            SendUpdate("SHIELDHIT", true.ToString());
            if (OverShield <= 0)
            {
                Debug.Log("Sendupdate for shieldbreak");
                SendUpdate("SHIELDBREAK", true.ToString());
            }
            if (this.GetComponent<NetworkPlayerController>().isSentry)
            {
                if(!this.GetComponent<SentryScript>().SentryPassive && this.GetComponent<NetworkPlayerController>().SuperCharge > 0)
                {
                    this.GetComponent<NetworkPlayerController>().SuperCharge -= 2;
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
        StartCoroutine(MineExplosion());
    }

    public IEnumerator MineExplosion()
    {
        yield return new WaitForSeconds(0.5f);
        GameObject temp = Instantiate(TripMineEffect, this.transform);
        yield return new WaitForSeconds(1.5f);
        Destroy(temp);
    }

    public void gotRailed()
    {
        OverShield = 0;
        HP = 0;
        SendUpdate("SHIELD",OverShield.ToString());
        SendUpdate("HP", HP.ToString());
    }
    public void gotBusted()
    {
        OverShield = 0;
        HP -= 25;
        SendUpdate("SHIELD", OverShield.ToString());
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

            if(HP <= 50 && HP >= 45)
            {
                Debug.Log("HEALTH IS LOW");
                HealthIsLow = true;
            }
            
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
        if(IsClient && flag == "SHIELDHIT")
        {
            //will always tell client that ShieldIsHit = true
            Debug.Log("Inside SHIELDHIT HM");
            ShieldIsHit = true;
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
        //AudioScript = this.GetComponent<PlayerAudioSFX>();

    }

    // Update is called once per frame
    public void Update()
    { 
        if(IsClient)
        {
            
            if (this.OverShield <= 0)
            {
                
                //PlayerOvershield.SetActive(false);
                this.transform.GetChild(2).gameObject.SetActive(false);
            }
            else 
            {
                
                //PlayerOvershield.SetActive(true);
                this.transform.GetChild(2).gameObject.SetActive(true);
            }
            

            if (IsLocalPlayer)
            {
                if(ShieldIsHit && OverShield > 0)
                {
                    ShieldIsHit = false;
                    
                    //Play shield hit audio SFX
                    this.GetComponent<PlayerAudioSFX>().PlayShieldHitAudio();
                }


                if(ShieldIsBroken)
                {
                    ShieldIsBroken = false;
                    
                    //Play Shield Broken SFX
                    this.GetComponent<PlayerAudioSFX>().PlayShieldBreakAudio();
                    Debug.Log("Playing OneShot");
                }

                if(HealthIsLow)
                {
                    Debug.Log("PLAYING HEALTH IS LOW SFX");
                    HealthIsLow = false;
                    //Play health low alert SFX
                    this.GetComponent<PlayerAudioSFX>().PlayHealthLowAudio();
                }
            }

        }
    }
}
