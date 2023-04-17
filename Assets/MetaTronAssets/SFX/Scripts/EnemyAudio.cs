using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyAudio : MonoBehaviour
{
    public AudioSource PlayerAudio;

    public AudioClip LazerAudio;
    public AudioClip DeathAudio;

    // Start is called before the first frame update
    void Start()
    {
        PlayerAudio = GetComponent<AudioSource>();
    }

    // Update is called once per frame
    void Update()
    {
       
    }

    public void PlayLazerAudio()
    {
        PlayerAudio.PlayOneShot(LazerAudio, .5f);
    }

    public void PlayDeathAudio()
    {
        PlayerAudio.PlayOneShot(DeathAudio, .3f);
    }


}
