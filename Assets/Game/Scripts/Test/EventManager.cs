using UnityEngine;
using UnityEngine.Events;
using System.Collections;
using System.Collections.Generic;

//https://unity3d.com/kr/learn/tutorials/topics/scripting/events-creating-simple-messaging-system

public class EventManager : MonoBehaviour
{
    #region Singleton
    private static EventManager eventManager;
    public static EventManager Instance
    {
        get
        {
            if (!eventManager)
            {
                eventManager = FindObjectOfType(typeof(EventManager)) as EventManager;

                if (!eventManager)
                {
                    Debug.LogError("Scene에 EventManager가 존재하지 않습니다.");
                }
                else
                {
                    eventManager.Init();
                }
            }

            return eventManager;
        }
    }
    #endregion

    public enum CustomEventType
    {
        ON_SCREEN_RAY = 1001,
        MOVE = 2001,
    }
    private Dictionary<CustomEventType, UnityEvent> eventDictionary;

    void Init()
    {
        if (eventDictionary == null)
        {
            eventDictionary = new Dictionary<CustomEventType, UnityEvent>();
        }
    }

    public static void StartListening(CustomEventType eventType, UnityAction listener)
    {
        UnityEvent thisEvent = null;
        if (Instance.eventDictionary.TryGetValue(eventType, out thisEvent))
        {
            thisEvent.AddListener(listener);
        }
        else
        {
            thisEvent = new UnityEvent();
            thisEvent.AddListener(listener);
            Instance.eventDictionary.Add(eventType, thisEvent);
        }
    }

    public static void StopListening(CustomEventType eventType, UnityAction listener)
    {
        if (eventManager == null) return;
        UnityEvent thisEvent = null;
        if (Instance.eventDictionary.TryGetValue(eventType, out thisEvent))
        {
            thisEvent.RemoveListener(listener);
        }
    }

    public static void TriggerEvent(CustomEventType eventType)
    {
        UnityEvent thisEvent = null;
        if (Instance.eventDictionary.TryGetValue(eventType, out thisEvent))
        {
            thisEvent.Invoke();
        }
    }
}

