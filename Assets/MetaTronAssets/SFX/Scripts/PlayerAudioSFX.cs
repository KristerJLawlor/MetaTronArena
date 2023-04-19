using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerAudioSFX : MonoBehaviour
{
    public AudioSource PlayerAudio;

    public AudioClip LazerAudio;
    public AudioClip OverheatAudio;
    public AudioClip ExhaustAudio;
    public AudioClip ShieldHitAudio;
    public AudioClip ShieldBreakAudio;
    public AudioClip ShieldRegenAudio;
    public AudioClip WalkAudio;
    public AudioClip RunAudio;
    public AudioClip HealthLowAudio;
    public AudioClip DeathAudio;
    public AudioClip TimerAudio;
    public AudioClip PickupAudio;
    public AudioClip ScoreUpAudio;
    public AudioClip Railgun;


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
        PlayerAudio.PlayOneShot(LazerAudio, 1);
    }

    public void PlayOverheatAudio()
    {
        PlayerAudio.PlayOneShot(OverheatAudio, 1);
    }

    public void PlayExhaustAudio()
    {
        PlayerAudio.PlayOneShot(ExhaustAudio, 1);
    }

    public void PlayShieldHitAudio()
    {
        PlayerAudio.PlayOneShot(ShieldHitAudio, 1);
    }

    public void PlayShieldBreakAudio()
    {
        PlayerAudio.PlayOneShot(ShieldBreakAudio, 1);
    }

    public void PlayShieldRegenAudio()
    {
        PlayerAudio.PlayOneShot(ShieldRegenAudio, 1);
    }

    public void PlayWalkAudio()
    {
        PlayerAudio.PlayOneShot(WalkAudio, 1);
    }

    public void PlayRunAudio()
    {
        PlayerAudio.PlayOneShot(RunAudio, 1);
    }

    public void PlayHealthLowAudio()
    {
        PlayerAudio.PlayOneShot(HealthLowAudio, 1);
    }

    public void PlayDeathAudio()
    {
        PlayerAudio.PlayOneShot(DeathAudio, .5f);
    }

    public void PlayTimerAudio()
    {
        PlayerAudio.PlayOneShot(TimerAudio, .5f);
    }

    public void PlayPickupAudio()
    {
        PlayerAudio.PlayOneShot(PickupAudio, .8f);
    }

    public void PlayScoreUpAudio()
    {
        PlayerAudio.PlayOneShot(ScoreUpAudio, .8f);
    }
    public void RailgunShot()
    {
        PlayerAudio.PlayOneShot(Railgun, 3);
    }
}
