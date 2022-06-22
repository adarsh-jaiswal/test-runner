package com.graphql.testrunner.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

import org.springframework.stereotype.Service;

@Service
public class TestRunnerService {

//    private static final String REPO_URL = "https://github.com/graphql-java/graphql-java.git";
    private static final String REPO_URL = "https://github.com/jbellenger/graphql-java.git";

    public void runTest(String commitHash) {
        ProcessBuilder processBuilder = new ProcessBuilder();

        // Run a shell script
        processBuilder.command("sh",  "test-runner.sh",
          REPO_URL,
          commitHash);
        //processBuilder.command("sh", "-c", "ls");

        //for mac
        //processBuilder.command("bash", "-c", "ls");
        try {
            Process process = processBuilder.start();
            StringBuilder output = new StringBuilder();
            BufferedReader reader = new BufferedReader(
              new InputStreamReader(process.getInputStream()));

            String line;
            while ((line = reader.readLine()) != null) {
                output.append(line + "\n");
            }

            int exitVal = process.waitFor();
            if (exitVal == 0) {
                System.out.println("logs:");
                System.out.println(output);
            }

        } catch (IOException e) {
            System.out.println("IOException:" + e.getMessage());
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

}
