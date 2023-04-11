using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameMusicScript : MonoBehaviour
{

    public AudioSource GameMusic;

    public AudioClip MenuClip;
    public AudioClip ArenaClip;

    // Start is called before the first frame update
    void Start()
    {
        GameMusic = GetComponent<AudioSource>();
        GameMusic.loop = true;
        GameMusic.clip = MenuClip;
        GameMusic.Play();
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public void PlayGameMusic()
    {
        GameMusic.clip = ArenaClip;
        GameMusic.Play();
    }

}
