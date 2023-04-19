using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using NETWORK_ENGINE;


public class CloneScript : HighLevelEntity
{
    GameObject[] Players;
    public RaycastHit hit;
    public Rigidbody body;

    //Variables for animators
    public Animator PlayerAnimation;
    public bool isAttacking = false;

    //Variables for particle effect
    public GameObject LaserPrefab;
    public GameObject LaserBeam;
    public override void HandleMessage(string flag, string value)
    {
        base.HandleMessage(flag, value);

        if (flag == "ISATTACKING")
        {
            //Debug.Log("flag ISATTACKING = " + value);
            isAttacking = bool.Parse(value);
            if (IsServer)
            {
                SendUpdate("ISATTACKING", isAttacking.ToString());
            }
        }
    }

    public override void NetworkedStart()
    {
        base.NetworkedStart();
        
    }

    public override IEnumerator SlowUpdate()
    {
        base.SlowUpdate();
        while(IsServer)
        {
            foreach(var p in Players)
            {
                body.velocity = Vector3.zero;
                Debug.Log("A"+ Players.Length);
                if(this.Owner == p.GetComponent<NetworkID>().Owner)
                {
                    Debug.Log("B");
                    continue;
                }
                Debug.Log("B2");
                if ((transform.position - p.transform.position).magnitude < 25)
                {
                    Debug.Log("C");
                    if(Physics.Raycast(transform.position+transform.up*.5f, (p.transform.position-transform.position).normalized, out hit))
                    {
                       Debug.Log("D" + hit.collider.name);
                        Debug.DrawRay(transform.position + transform.up * .5f, (p.transform.position - transform.position).normalized, Color.blue);
                        if (hit.collider.tag == "Entity")
                        {
                            //move toward target
                            SendUpdate("ISATTACKING", true.ToString());
                            body.velocity = (p.transform.position - transform.position).normalized * 1.5f;
                            hit.transform.GetComponent<HighLevelEntity>().Damage(.2f, false);
                            this.transform.forward = (p.transform.position - transform.position).normalized;
                            Debug.Log("E");
                            break;
                        }
                        else
                        {
                            SendUpdate("ISATTACKING", false.ToString());
                        }
                    }
                }
            }
            yield return new WaitForSeconds(.1f);
        }
        
    }

    // Start is called before the first frame update
    void Start()
    {
        if (IsServer)
        {
            Players = GameObject.FindGameObjectsWithTag("Entity");
            OverShield = 0;
            SendUpdate("SHIELD", OverShield.ToString());
            HP = 25;
            SendUpdate("HP", HP.ToString());
            body=GetComponent<Rigidbody>();
        }
        PlayerAnimation = GetComponent<Animator>();
    }

    // Update is called once per frame
    void Update()
    {
        base.Update();
        if (IsServer)
        {
            if (HP <= 0)
            {
                MyCore.NetDestroyObject(this.NetId);
            }
        }


        //Animations in IsClient
        if (IsClient)
        {
            PlayerAnimation.SetBool("Idle", false);

                if (isAttacking)
                {
                    //Debug.Log("WALK ATTACK ANIMATION");
                    PlayerAnimation.SetBool("WalkAttack", true);

                    PlayerAnimation.SetBool("Idle", false);
                    PlayerAnimation.SetBool("Attack", false);
                    PlayerAnimation.SetBool("Walk", false);

                }

                else if (!isAttacking)
                {
                    //Debug.Log("IDLE ANIMATION");
                    PlayerAnimation.SetBool("Idle", true);

                    PlayerAnimation.SetBool("WalkAttack", false);
                    PlayerAnimation.SetBool("Attack", false);
                    PlayerAnimation.SetBool("Walk", false);
                }



            }

            if (isAttacking)
            {
                //Debug.Log("Spawn Laser");
                Destroy(LaserBeam);
                LaserBeam = Instantiate(LaserPrefab, body.transform.forward + this.transform.position + new Vector3(0, 1.0f, 0), this.transform.rotation);

                //this.GetComponent<PlayerAudioSFX>().PlayLazerAudio();


            }
            else
            {
                Destroy(LaserBeam, 0.5f);
            }

        }

    }
}
