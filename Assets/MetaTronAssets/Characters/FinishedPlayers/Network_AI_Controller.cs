using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using NETWORK_ENGINE;

public class Network_AI_Controller : HighLevelEntity
{
    GameObject[] Players;
    public RaycastHit hit;
    public Rigidbody body;

    //Variables for animators
    public Animator PlayerAnimation;
    public bool isAttacking = false;
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
        while (IsServer)
        {
            foreach (var p in Players)
            {
                body.velocity = Vector3.zero;
                //Debug.Log("A" + Players.Length);
                if (this.Owner == p.GetComponent<NetworkID>().Owner)
                {
                    //Debug.Log("B");
                    continue;
                }
                //Debug.Log("B2");
                if ((transform.position - p.transform.position).magnitude < 25)
                {
                    //Debug.Log("C");
                    if (Physics.Raycast(transform.position + transform.up * .5f, (p.transform.position - transform.position).normalized, out hit))
                    {
                        //Debug.Log("D" + hit.collider.name);
                        //Debug.DrawRay(transform.position + transform.up * .5f, (p.transform.position - transform.position).normalized, Color.blue);
                        if (hit.collider.tag == "Entity")
                        {
                            //move toward target
                            SendUpdate("ISATTACKING", true.ToString());
                            body.velocity = (p.transform.position - transform.position).normalized * 2f;
                            this.transform.forward = (p.transform.position - transform.position).normalized;
                            //Debug.Log("E");
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
            body = GetComponent<Rigidbody>();
        }
        PlayerAnimation = GetComponent<Animator>();
    }

    // Update is called once per frame
    void Update()
    {
        //base.Update();
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
                PlayerAnimation.SetBool("Walk", true);

                PlayerAnimation.SetBool("Idle", false);
                PlayerAnimation.SetBool("Attack", false);
                PlayerAnimation.SetBool("WalkAttack", false);

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

    }
    public void OnCollisionEnter(Collision collision)
    {
        if(collision.transform.tag == "Entity")
        {
            collision.transform.GetComponent<HighLevelEntity>().trippedMine();
        }
        
    }
    
}
