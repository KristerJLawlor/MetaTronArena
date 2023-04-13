using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class AbilityCooldown : MonoBehaviour
{
    public Slider A_Ability;
    
    // Start is called before the first frame update
    void Start()
    {

    }

    // Update is called once per frame
    void Update()
    {

    }
    
    public void ChangeSliderValue(float cooldown)
    {
        A_Ability.value = cooldown;
    }
    public void ChangeSliderMaxValue(float CTime)
    {
        A_Ability.maxValue = CTime;
    }
}
