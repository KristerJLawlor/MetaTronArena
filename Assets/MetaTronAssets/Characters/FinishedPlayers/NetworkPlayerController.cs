using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

using NETWORK_ENGINE;
using Unity.VisualScripting;

public class NetworkPlayerController : HighLevelEntity
{

    public Vector2 LastInput;
    public Vector2 AimVector;
    public Vector3 AimPosition;
    public Vector3 AimDirection;
    public Rigidbody myRig;
    public float speed = 5;
    public float Overheat = 0;
    public float MaxHeat = 100;
    public bool canShoot = true;
    public bool lastFire=false;
    public bool passiveActive = false;
    public string pname;
    public int AbilityCharge = 0;
    public int maxCharge = 1000;
    public int SuperCharge = 100;
    public int maxSuperCharge = 100;
    public bool AbilityinUse = false;
    public  RaycastHit hit;
    public Vector3 SpawnLoc;
    public int Score = 0;
    public bool isSentry = false;
    public bool isMarksman = false;


    //Variables for animators
    public Animator PlayerAnimation;
    public bool isAttacking = false;
    public bool isDying = false;
    //Variables for particle effect
    public GameObject LaserPrefab;
    public GameObject LaserBeam;

    //Variables for audio
    public bool isOH = false;
    public bool canPew = true;
    public bool isReloading = false;
    public bool canWalk = true;
    public bool canOverheat = true;

    public Vector2 ParseV2(string v)
    {
        Vector2 temp = new Vector2();
        string[] args = v.Trim('(').Trim(')').Split(',');
        temp.x = float.Parse(args[0]); 
        temp.y = float.Parse(args[1]);
        return temp;
    }
    public Vector3 ParseV3(string v)
    {
        Vector3 temp = new Vector3();
        string[] args = v.Trim('(').Trim(')').Split(',');
        temp.x = float.Parse(args[0]);
        temp.y = float.Parse(args[1]);
        temp.z = float.Parse(args[2]);
        return temp;
    }

    public void ActionHandler(InputAction.CallbackContext c)
    {
       if(IsLocalPlayer)
        {
            if (c.started || c.performed)
            {
                //Send input
                SendCommand("MVC", c.ReadValue<Vector2>().ToString("F2"));
            }
            else if (c.canceled)
            {
                //Send vector 2.zero.
                SendCommand("MVC", Vector2.zero.ToString("F2"));
            }
        }
    }
    public void Aiming(InputAction.CallbackContext a)
    {
        if(IsLocalPlayer)
        {
            myRig.angularVelocity = new Vector3(0, 0, 0);
            myRig.rotation = Quaternion.Euler(0, a.ReadValue<Vector2>().x+myRig.rotation.eulerAngles.y, 0);
            SendCommand("AIM", a.ReadValue<Vector2>().ToString());
        }
    }
    public void Shoot(InputAction.CallbackContext s)
    {
        if (IsLocalPlayer)
        {
            if (s.started)
            {
                Debug.Log("Shoot function");
                SendCommand("FIRE", "true");
                SendCommand("ISATTACKING", true.ToString());
                
            }

            else if (s.canceled)
            {
                SendCommand("FIRE", "false");
                SendCommand("ISATTACKING", false.ToString());
                
            }
        }
    }
    public void HeatVent(InputAction.CallbackContext h)
    {
        if (IsLocalPlayer && Overheat<100) 
        {
            SendCommand("RELOAD", "''");
        }
    }
    public IEnumerator Reload()
    {
        yield return new WaitForSeconds(2);
        canShoot = true;
        Overheat = 0;
        SendUpdate("OH", Overheat.ToString());
        SendUpdate("CANSHOOT", canShoot.ToString());

        

    }
    /*public IEnumerator ROF()
    {
        if (Overheat < 100)
        {
            yield return new WaitForSeconds(.25f);
            canShoot = true;
            SendUpdate("CANSHOOT", canShoot.ToString());
            
        }
    }
    */

    public IEnumerator ROFSFX()
    {
        if (Overheat < 100)
        {
            yield return new WaitForSeconds(.5f);
            canPew = true;
            SendUpdate("CANPEWPEW", canPew.ToString());
        }
    }
    public IEnumerator OH()
    {
        yield return new WaitForSeconds(5);
        Overheat= 0;       
        canShoot= true;
        SendUpdate("CANSHOOT", canShoot.ToString());
        SendUpdate("OH", Overheat.ToString());
        canOverheat = true;
        SendUpdate("CANOVERHEAT", true.ToString());
    }
    
    public override void HandleMessage(string flag, string value)
    {
        base.HandleMessage(flag, value);
        if (IsClient && flag == "SHIELD")
        {
            OverShield = int.Parse(value);
        }
        if (IsClient && flag == "HP")
        {
            HP = int.Parse(value);
        }
        if (IsServer && flag == "MVC")
        { 
            LastInput = ParseV2(value);
            StartCoroutine(Walk());            
        }
        if(IsServer && flag == "AIM")
        {
            AimVector = ParseV2(value);
        }


        if(IsClient && flag == "FIRE")
        {
            lastFire = bool.Parse(value);
        }


        if(IsServer && flag == "FIRE")
        {
            lastFire = bool.Parse(value);

            //Sendupdate to client
            SendUpdate("FIRE", lastFire.ToString());
        }

        if(IsClient && flag == "CANSHOOT")
        {
            canShoot= bool.Parse(value);
            
        }
        if(IsClient && flag == "OH")
        {
            Overheat = float.Parse(value);
         
        }
        if(IsServer && flag == "RELOAD")
        {
            canShoot = false;
            SendUpdate("CANSHOOT", "false");
            isReloading = true;
            SendUpdate("ISRELOADING", true.ToString());
            StartCoroutine(Reload());
        }
        if(IsServer && flag == "AP")
        {
            AimPosition = ParseV3(value);
            
        }
        if(IsServer && flag == "AD")
        {
            AimDirection= ParseV3(value);
            
        }
        if(IsClient && flag == "ACHARGE")
        {
            AbilityCharge=int.Parse(value);
        }
        if(IsClient && flag == "SCHARGE")
        {
            SuperCharge=int.Parse(value);
        }
        if(IsServer && flag == "PN")
        {
            pname = value;
        }
        if(flag == "ISATTACKING")
        {
            //Debug.Log("flag ISATTACKING = " + value);
            isAttacking = bool.Parse(value);
            if(IsServer)
            {
                SendUpdate("ISATTACKING", isAttacking.ToString());
            }
        }
        if(flag == "ISDYING")
        {
            //Debug.Log("flag ISDYING = " + value);
            isDying = bool.Parse(value);
            if (IsServer)
            {
                SendUpdate("ISDYING", isDying.ToString());
            }
        }
        if(IsClient && flag == "ISOVERHEATING")
        {
            isOH = bool.Parse(value);
        }
        if (IsClient && flag == "ISRELOADING")
        {
            isReloading = true;
        }
        if (IsClient && flag == "CANPEWPEW")
        {
            canPew = bool.Parse(value);
        }
        if(IsClient && flag == "CANWALK")
        {
            canWalk = bool.Parse(value);
        }
        if(flag == "CANOVERHEAT")
        {
            canOverheat = bool.Parse(value);
        }
        if(IsClient && flag == "SCORE")
        {
            Score = int.Parse(value);
        }
    }

    public override void NetworkedStart()
    {
      
    }
    public virtual float OnDamage(float d, GameObject o)
    { 
        return d;
    }
    public override IEnumerator SlowUpdate()
    {
        foreach(NPMScript npm in GameObject.FindObjectsOfType<NPMScript>())
        {
            if (npm.Owner == this.Owner)
            {
                pname = npm.PName;
                SendUpdate("PN",npm.PName);
            }
        }
        while(IsServer)
        {
            if(lastFire && canShoot)
            {
                
                if(Physics.Raycast(transform.position + transform.forward * 1.6f + transform.up * 1.2f, transform.forward, out hit))
                {
                    if(hit.collider.tag=="Entity" || hit.collider.tag=="Clone" || hit.collider.tag=="Turret")
                       {
                        if ((hit.transform.position - transform.position).magnitude >= 25 && isMarksman)
                        {
                            hit.transform.GetComponent<HighLevelEntity>().Damage(OnDamage(2.5f, hit.transform.gameObject), this.AProunds);
                            if (SuperCharge > 0)
                            {
                                SuperCharge -= 2;
                                SendUpdate("SCHARGE", SuperCharge.ToString());
                            }
                        }
                        else
                        {
                            hit.transform.GetComponent<HighLevelEntity>().Damage(OnDamage(this.DamageScalar, hit.transform.gameObject), this.AProunds);
                        }
                        if (hit.transform.GetComponent<HighLevelEntity>().HP <= 0)
                        {
                            Score++;
                            SendUpdate("SCORE", Score.ToString());
                        }
                        if(passiveActive && SuperCharge>0)
                        {
                            SuperCharge -= 2;
                            SendUpdate("SCHARGE", SuperCharge.ToString());
                        }
                        
                       }
                    
                }
                Overheat = Overheat + 2;
                SendUpdate("OH", Overheat.ToString());
                //canShoot = false;
                //SendUpdate("CANSHOOT", canShoot.ToString());
                //StartCoroutine(ROF());
                StartCoroutine(ROFSFX());
            }
            if (Overheat >= 100)
            {
                canShoot = false;
                
                SendUpdate("CANSHOOT", canShoot.ToString());

                isOH = true;
                SendUpdate("ISOVERHEATING", true.ToString());

                if(canOverheat)
                {
                    canOverheat = false;
                    StartCoroutine(OH());
                }
                

            }
            if (!lastFire && Overheat > 0 && Overheat<100)
            {
                Overheat= Overheat - .1f;
                SendUpdate("OH", Overheat.ToString());
            }
            if (IsDirty)
            {
                SendUpdate("PN", pname);
                SendUpdate("MVC", myRig.velocity.ToString());
                IsDirty= false;
            }
            if (HP <= 0)
            {
                //Send update to client that this player is dying
                isDying = true;
                SendUpdate("ISDYING", "true");
                StartCoroutine(Respawn());
            }
            if(AbilityCharge > 0 && !AbilityinUse)
            {
                AbilityCharge-=4;
                SendUpdate("ACHARGE", AbilityCharge.ToString());
            }
            yield return new WaitForSeconds(.1f);
        }
        while (IsLocalPlayer)
        {
            SendCommand("AP", Camera.main.transform.position.ToString());
            SendCommand("AD", Camera.main.transform.forward.ToString());
            yield return new WaitForSeconds(.1f);
        }
    }

    // Start is called before the first frame update
    public void Start()
    {
        myRig = GetComponent<Rigidbody>();
        PlayerAnimation = GetComponent<Animator>();
        SpawnLoc= myRig.position;
        
    }

    // Update is called once per frame
    public void Update()
    {
        base.Update();
        if (IsServer && HP>0)
        {
            myRig.velocity = transform.forward * LastInput.y * speed + transform.right * LastInput.x *speed;
            myRig.angularVelocity = new Vector3(0, 0, 0);
            myRig.rotation = Quaternion.Euler(0, AimVector.x + myRig.rotation.eulerAngles.y, 0); //Quaternion.Lerp(myRig.rotation, Quaternion.Euler(myRig.rotation.eulerAngles + new Vector3(0, AimVector.x, 0)), Time.deltaTime * 7f);
        }
        if (IsLocalPlayer)
        {
            
            Camera.main.transform.position = this.GetComponent<Rigidbody>().position + this.GetComponent<Rigidbody>().rotation*Vector3.forward * 1.6f + this.GetComponent<Rigidbody>().rotation*Vector3.up *1.2f;
            Camera.main.transform.rotation = Quaternion.Lerp(Camera.main.transform.rotation, this.GetComponent<Rigidbody>().rotation, Time.deltaTime*speed);
            




        }
        //Animations in IsClient
        if(IsClient)
        {
            PlayerAnimation.SetBool("Idle", false);

            if (!isDying)
            {


                if (isAttacking && myRig.velocity.magnitude > 0.1f)
                {
                    //Debug.Log("WALK ATTACK ANIMATION");
                    PlayerAnimation.SetBool("WalkAttack", true);

                    PlayerAnimation.SetBool("Idle", false);
                    PlayerAnimation.SetBool("Attack", false);
                    PlayerAnimation.SetBool("Walk", false);

                }
                else if (isAttacking && myRig.velocity.magnitude <= 0.1f)
                {
                    //Debug.Log("SHOOT ANIMATION");
                    PlayerAnimation.SetBool("Attack", true);

                    PlayerAnimation.SetBool("Idle", false);
                    PlayerAnimation.SetBool("WalkAttack", false);
                    PlayerAnimation.SetBool("Walk", false);

                }

                else if (!isAttacking && myRig.velocity.magnitude > 0.1f)
                {
                    //Debug.Log("WALK ANIMATION");
                    PlayerAnimation.SetBool("Walk", true);

                    PlayerAnimation.SetBool("Idle", false);
                    PlayerAnimation.SetBool("Attack", false);
                    PlayerAnimation.SetBool("WalkAttack", false);


                }
                else if (!isAttacking && myRig.velocity.magnitude <= 0.1f)
                {
                    //Debug.Log("IDLE ANIMATION");
                    PlayerAnimation.SetBool("Idle", true);

                    PlayerAnimation.SetBool("WalkAttack", false);
                    PlayerAnimation.SetBool("Attack", false);
                    PlayerAnimation.SetBool("Walk", false);
                }



            }
            else
            {
                isDying = false;
                //Debug.Log("DYING ANIMATION");
                PlayerAnimation.SetTrigger("Die");

                //Play death audio SFX
                this.GetComponent<PlayerAudioSFX>().PlayDeathAudio();
            }

            if (canShoot && isAttacking)
            {
                //Debug.Log("Spawn Laser");
                Destroy(LaserBeam);
                LaserBeam = Instantiate(LaserPrefab, myRig.transform.forward + myRig.transform.position + new Vector3(0, 1.0f, 0), myRig.transform.rotation);
                
                if(canPew)
                {
                    canPew = false;
                    this.GetComponent<PlayerAudioSFX>().PlayLazerAudio();
                }

            }
            else
            {
                Destroy(LaserBeam, 0.5f);
            }

            if(canWalk && myRig.velocity.magnitude > 0.1f)
            {
                canWalk = false;
                this.GetComponent<PlayerAudioSFX>().PlayWalkAudio();
            }

            if (IsLocalPlayer)
            {
                if (!canShoot && isOH && canOverheat && Overheat >= 100)
                {
                    Debug.Log("Playing Overheat.");

                    //play overheat SFX
                    isOH = false;
                    canOverheat = false;
                    this.GetComponent<PlayerAudioSFX>().PlayOverheatAudio();
                }
                if (!canShoot && isReloading)
                {
                    //play reload SFX
                    isReloading = false;
                    this.GetComponent<PlayerAudioSFX>().PlayExhaustAudio();
                }
            }
        }
    }
    
    public IEnumerator Respawn()
    {
        yield return new WaitForSeconds(3);
        myRig.position= SpawnLoc;
        HP = 100;
        OverShield=50;
        SendUpdate("SHIELD", OverShield.ToString());
        SendUpdate("HP", HP.ToString());
        //Send update to client that this player is no longer dying
        isDying = false;
        SendUpdate("ISDYING", "false");
        myRig.transform.forward = Vector3.zero;
    }

    public IEnumerator Walk()
    {
        yield return new WaitForSeconds(1);
        canWalk = true;
        SendUpdate("CANWALK", canWalk.ToString());
    }


}
