int boys = 0;
    int girls = 0;
    for (Student s : lst) {
        if (s.gender.startsWith("M")) {
            boys++;
        }
        else {
