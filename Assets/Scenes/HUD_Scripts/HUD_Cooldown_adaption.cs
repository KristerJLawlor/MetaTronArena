using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class HUD_Cooldown_adaption : MonoBehaviour
{
    public Slider A_Ability;
    public Slider S_Ability;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }
    public void ActiveValue(float Acooldown)
    {
        A_Ability.value = Acooldown;
    }
    public void ActiveMax(float ACTime)
    {
        A_Ability.maxValue = ACTime;
    }
    public void SuperValue(float Scooldown)
    {
        A_Ability.value = Scooldown;
    }
    public void SuperMax(float SCTime)
    {
        A_Ability.maxValue = SCTime;
    }
}
