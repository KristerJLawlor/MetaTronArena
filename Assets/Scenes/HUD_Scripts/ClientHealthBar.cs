using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ClientHealthBar : MonoBehaviour
{
    public Image ShieldBar;
    public Image[] HPoints;
    public NetworkPlayerController Owner;

    float LerpSpeed;

    //temp values
    public float MaxHealth = 100;
    public float CurHealth;

    public float MaxShields = 50;
    public float CurShields;


    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        /*//Just in case
        if(CurShields > MaxShields) CurShields = MaxShields;
        if (CurHealth > MaxHealth) CurHealth = MaxHealth;
        if (CurShields < 0) CurShields = 0;
        if (CurHealth < 0) CurHealth = 0;
        */
        LerpSpeed = 3f * Time.deltaTime;

        CHealthbarFill();
    }
    public void CHealthbarFill()
    {
        ShieldBar.fillAmount = Mathf.Lerp(ShieldBar.fillAmount, Owner.OverShield / Owner.maxOverShield, LerpSpeed);

        for (int i = 0; i < HPoints.Length; i++)
        {
            HPoints[i].enabled = !CDisplayHitPoint(Owner.HP, i);
        }
    }
    public bool CDisplayHitPoint(float health, int Hpoint)
    {
        return ((Hpoint * (Owner.maxHP / 10)) >= health);
        //Owner.NetId =tester
    }
}
