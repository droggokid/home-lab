#include <thread>
#include <iostream>
#include <mutex>
#include <chrono>
#include <vector>

class Carousel // g++ -std=c++17 -O2 -Wall -Wextra -pthread threads.cpp -o threads
{
public:
    Carousel(int capacity)
    {
        capacity_ = capacity;
    }

    void enter()
    {
        while (true)
        {
            mutex_capacity.lock(); // vi låser shared resource, så kun én tråd ad gangen kan læse/ændre capacity_

            if (capacity_ > 0) // hvis der er plads, tager vi en plads og forlader loopet
            {
                --capacity_;
                std::cout << capacity_ << " plads tilbage\n";
                mutex_capacity.unlock();
                break;
            }
            else
            {
                std::cout << "Der er ikke plads, venter\n";
                mutex_capacity.unlock();                              // unlock imens den her tråd venter, så andre kan komme ind/ud
                std::this_thread::sleep_for(std::chrono::seconds(1)); // vent i 1 sek
            }
        }

        run(); // arbejde sker uden at holde låsen
    }

    void run()
    {
        std::cout << "Tråd " << std::this_thread::get_id() << ", kører i rutjebanen\n";
        std::this_thread::sleep_for(std::chrono::seconds(5)); // lad som om der sker noget i 5 sekunder
        exit();                                               // exit derefter
    }

    void exit()
    {
        mutex_capacity.lock(); // samme mutex som i enter(), ellers får vi data race
        ++capacity_;
        mutex_capacity.unlock();
        std::cout << "Tråd " << std::this_thread::get_id() << ", forlader\n";
        std::this_thread::yield();
    }

private:
    int capacity_;             // privat variabel til at holde styr på capacity, det bliver vores shared resource
    std::mutex mutex_capacity; // samme mutex bruges ved både enter() og exit()
};

int main()
{
    Carousel carousel = Carousel(3); // Her laver jeg en objekt af klassen jeg definerede ovenpå, med en capacity på 3

    std::vector<std::thread> threads;
    threads.reserve(6);
    for (int i = 0; i < 6; ++i)
    {
        threads.emplace_back(&Carousel::enter, &carousel);
    }

    for (auto &th : threads)
    {
        th.join();
    }

    return 0;
}
