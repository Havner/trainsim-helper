using System;
using System.Windows.Forms;
using System.IO;
using System.Text.RegularExpressions;

namespace Lua_Out_Editor
{
    public partial class Form1 : Form
    {
        private string appPath = Application.StartupPath;
        private string railworksPath = "";
        private string lastDirectory = "";
        private string templateFileName = "trainsim-helper-engine-template.lua";

        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            // Get path to railworks
            railworksPath = (string)Microsoft.Win32.Registry.GetValue(@"HKEY_LOCAL_MACHINE\SOFTWARE\railsimulator.com\railworks\", "Install_Path", "Not present");
            if (railworksPath == null || !Directory.Exists(railworksPath))
            {
                MessageBox.Show("Can't find Train Simulator registry entry or the directory itself." + Environment.NewLine +
                    "I need it to locate a LUA compiler.",
                    "Train Simulator not found", MessageBoxButtons.OK, MessageBoxIcon.Stop);
                this.Close();
            }

            if (!File.Exists(railworksPath + "\\luac.exe"))
            {
                MessageBox.Show("Can't find the LUA compiler in the Train Simulator directory.",
                    "LUA compiler not found", MessageBoxButtons.OK, MessageBoxIcon.Stop);
                this.Close();
            }

            if (!File.Exists(appPath + "\\trainsim-helper-engine-template.lua"))
            {
                MessageBox.Show("Can't find the template script. Make sure it is in the same directory as the program",
                    "Template file not found", MessageBoxButtons.OK, MessageBoxIcon.Stop);
                return;
            }
        }

        private void btnSelectFile_Click(object sender, EventArgs e)
        {
            string templateScript = appPath + "\\" + templateFileName;

            //Open an openfile dialogbox to get the file to edit from user
            OpenFileDialog ofd = new OpenFileDialog();
            //Check to see if we have navigated to a directory yet. If we haven't then use railworks
            //directory. If we have then use the last directory used.
            if (lastDirectory == "")
            {
                ofd.InitialDirectory = railworksPath;
            }
            else
            {
                ofd.InitialDirectory = lastDirectory;
            }
            ofd.Filter = "Train Sim files (*.lua; *.out)|*.lua; *.out";
            ofd.RestoreDirectory = true;
            if (ofd.ShowDialog() == DialogResult.OK)
            {
                StreamReader sr;
                bool found;
                
                string filePath = ofd.FileName;
                string fileName = Path.GetFileName(filePath);
                string fileNameWithoutExtension = Path.GetFileNameWithoutExtension(filePath);          
                string fileDirectory = Path.GetDirectoryName(filePath);
                string fileExtension = Path.GetExtension(filePath);

                // save for later
                lastDirectory = fileDirectory;

                string origFilePath = fileDirectory + "\\" + fileNameWithoutExtension + "_orig" + fileExtension;
                string tempFileScript = fileDirectory + "\\" + templateFileName;
                string newFileScript = fileDirectory + "\\" + fileNameWithoutExtension + fileExtension;

                if (fileName.Contains("_orig."))
                {
                    MessageBox.Show("You selected a file with an \"_orig\" in the name." + Environment.NewLine +
                        "This is probably a file that is a result of running this program. I can't operate on it.",
                        "Wrong file selected", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    return;
                }

                // Check to see if the file has already been edited
                sr = new StreamReader(filePath);
                found = false;
                while (!sr.EndOfStream)
                {
                    string tmp = sr.ReadLine();
                    if (tmp.Contains("plugins/trainsim-helper.lua"))
                    {
                        found = true;
                    }
                }
                sr.Close();
                if (found)
                {
                    if (File.Exists(origFilePath))
                    {
                        DialogResult dr = MessageBox.Show("The file " + fileName + " has already been processed." + Environment.NewLine +
                            "Do you wish to restore from the _orig and then re-process the file?",
                            "File already processed", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
                        if (dr == DialogResult.Yes)
                        {
                            File.Delete(filePath);
                            File.Move(origFilePath, filePath);
                        }
                        else
                        {
                            return;
                        }
                    }
                    else
                    {
                        MessageBox.Show("The file " + fileName + " has already been processed." + Environment.NewLine +
                            "As the original file is not present in the current folder" + Environment.NewLine +
                            "you cannot restore from the original and then re-process the file.",
                            "File already processed - original missing", MessageBoxButtons.OK, MessageBoxIcon.Stop);
                        return;
                    }
                }

                // Check whether the orig file already exists
                found = true;
                try
                {
                    sr = new StreamReader(origFilePath);
                    sr.Close();
                }
                catch (Exception)
                {
                    found = false;
                }
                if (found)
                {
                    DialogResult dr = MessageBox.Show("The file " + fileName + " doesn't seem to be processed," + Environment.NewLine +
                        "but the _orig file is there." + Environment.NewLine +
                        "This might happen after the Steam update/validation." + Environment.NewLine +
                        "Do you want to overwrite the _orig file and re-process the file?",
                        "Destination file exists", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
                    if (dr == DialogResult.Yes)
                    {
                        File.Delete(origFilePath);
                    }
                    else
                    {
                        return;
                    }
                }
                                
                // Check file is not read only if it is change it
                checkSetReadOnly(filePath);

                string strippedOrigFile = origFilePath;
                strippedOrigFile = Regex.Replace(strippedOrigFile, @"\\", @"/");
                string cutTo = "/railworks/";
                int cut = strippedOrigFile.IndexOf(cutTo, StringComparison.OrdinalIgnoreCase) + cutTo.Length;
                strippedOrigFile = strippedOrigFile.Substring(cut);

                File.Move(filePath, origFilePath);
                File.Delete(tempFileScript);
                File.Copy(templateScript, tempFileScript);
                ReplaceText(tempFileScript, "_ORIGINAL_SCRIPT_NAME_SUFFIXED_", strippedOrigFile);

                // Check if the original file was compiled, if so compile the new one
                if (fileExtension.Equals(".out", StringComparison.OrdinalIgnoreCase))
                {
                    bool rc = CompileScript(tempFileScript, newFileScript);
                    File.Delete(tempFileScript);

                    // if failed try to roll back
                    if (!rc)
                    {
                        File.Move(origFilePath, filePath);
                        return;
                    }
                }
                // If it was not compiled move the lua to the correct place
                else if (fileExtension.Equals(".lua", StringComparison.OrdinalIgnoreCase))
                {
                    File.Move(tempFileScript, newFileScript);
                }

                MessageBox.Show(fileName + " processed successfully.", "Success", MessageBoxButtons.OK, MessageBoxIcon.Asterisk);
            }
        }

        public bool CompileScript(string src, string dst)
        {
            System.Diagnostics.Process p = new System.Diagnostics.Process();
            p.StartInfo.CreateNoWindow = false;
            p.StartInfo.ErrorDialog = true;
            p.StartInfo.UseShellExecute = false;
            p.StartInfo.RedirectStandardError = true;
            p.StartInfo.FileName = railworksPath + "\\luac.exe";
            p.StartInfo.Arguments = " -o \"" + dst + "\" \"" + src + "\"";

            try
            {
                p.Start();
                string stdout = p.StandardError.ReadToEnd();
                p.WaitForExit();
                if (stdout.Length > 0)
                {
                    MessageBox.Show("Compilation failed" + Environment.NewLine + stdout, "Failed", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    return false;
                }
            }
            catch (Exception exception)
            {

                MessageBox.Show("Exception caught" + Environment.NewLine + exception.ToString(), "Exception", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return false;
            }
            return true;
        }

        public void ReplaceText(string fName, string findText, string replaceText)
        {
            StreamReader sr = new StreamReader(fName);
            string content = sr.ReadToEnd();
            sr.Close();

            content = Regex.Replace(content, findText, replaceText);
            StreamWriter sw = new StreamWriter(fName);
            sw.Write(content);
            sw.Close();
        }

        private void btnExit_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void checkSetReadOnly(string fname)
        {
            FileInfo fi = new FileInfo(fname);
            fi.IsReadOnly = false;
        }
    }
}
