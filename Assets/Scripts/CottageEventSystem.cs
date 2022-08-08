using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CottageEventSystem : MonoBehaviour
{
    public GameObject editCanvas;
    public GameObject viewCanvas;
    public GameObject furniture;
    // Start is called before the first frame update
    void Start()
    {
        //Start in View mode
        viewCanvas.SetActive(true);
        editCanvas.SetActive(false);
    }

    // Update is called once per frame
    void Update()
    {
        
    }



    public void EditButton()
    {
        //Set edit canvas active
        viewCanvas.SetActive(false);
        editCanvas.SetActive(true);

        //set Drag behaviour on furnitures
        var furnitureDrag = furniture.GetComponentsInChildren<FurnitureBehaviour>();
        foreach (var item in furnitureDrag)
        {
            item.dragOn = true;
        }
        
    }
    public void SaveButton()
    {
        // save positions
        // Set View canvas active
        // change behavior

        viewCanvas.SetActive(true);
        editCanvas.SetActive(false);

        var furnitureDrag = furniture.GetComponentsInChildren<FurnitureBehaviour>();
        foreach (var item in furnitureDrag)
        {
            item.dragOn = false;
        }
    }
}
