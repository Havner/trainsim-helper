using System;
using System.Windows.Forms;
using System.IO;
using System.Xml.Linq;
using System.Diagnostics;

namespace Data_Extractor
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private string appPath = Application.StartupPath;
        private string railworksPath = "";
        private string s = "";
        private XDocument doc;
        private string filename = "";
        private string inputmapperDirectory = "";
        private string engineDataDirectory = "";

        private void Form1_Load(object sender, EventArgs e)
        {
            loadSettings();
            if (!File.Exists(railworksPath + @"\serz.exe"))
            {
                checkRailworksPath();
            }
        }

        private string SanitizeFileName(string p)
        {
            string invalid = new string(Path.GetInvalidFileNameChars()) + new string(Path.GetInvalidPathChars());

            p = p.Replace("/", " "); 
            foreach (char c in invalid)
                p = p.Replace(c.ToString(), "");

            return p;
        }

        private void btnEngineDataFile_Click(object sender, EventArgs e)
        {
            string sName = "";
            //Open up a fileopen dialog box to allow user to select file to open
            OpenFileDialog ofd = new OpenFileDialog();
            ofd.Filter = "*bin files (*.bin)|*.bin";
            if (engineDataDirectory == "" && railworksPath != "Not present")
            {
                ofd.InitialDirectory = railworksPath + @"\assets\";
            }
            else if (engineDataDirectory != "")
            {
                ofd.InitialDirectory = engineDataDirectory;
            }
            else
            {
                ofd.InitialDirectory = appPath;
            }
            ofd.RestoreDirectory = true;

            if (ofd.ShowDialog() == DialogResult.OK)
            {
                filename = ofd.FileName;
                string filenameWithoutExtension = Path.GetFileNameWithoutExtension(filename);
                string fileDirectory = Path.GetDirectoryName(filename) + "\\";
                engineDataDirectory = fileDirectory;
                string fname = "";
                //Call serz.exe in railworks folder to extract loaded bin file to xml file
                try
                {
                    if (File.Exists(railworksPath + @"\serz.exe"))
                    {
                        Process p = new System.Diagnostics.Process();
                        p.StartInfo.CreateNoWindow = true; // false;
                        p.StartInfo.ErrorDialog = true;
                        p.StartInfo.UseShellExecute = false;// true;
                        p.StartInfo.FileName = railworksPath + "\\serz.exe";
                        p.StartInfo.Arguments = " \"" + filename + "\"";
                        p.Start();
                        p.WaitForExit(); 
                    }
                    else
                    {
                        MessageBox.Show("This program requires the file serz.exe to extract the data\r\nThis file does not exist in " + railworksPath
                            + "\r\nPlease select the \'Reset Railworks Path\' button and browse to your railworks.exe file", "Serz.exe Not Found");
                        return;
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Error:- " + ex.Message);
                    throw;
                }
                //Now extract data from the XML file we just extracted
                doc = XDocument.Load(fileDirectory + filenameWithoutExtension + ".xml");
                var EngineDataName = doc.Descendants("cEngineBlueprint");
                var EngineData = doc.Descendants("cControlContainerBlueprint-cControlValue");
                var EngineScript = doc.Descendants("cScriptComponentBlueprint");
                File.Delete(fileDirectory + filenameWithoutExtension + ".xml");
                try
                {
                    
                    foreach (var j in EngineDataName)
                    
                    {
                        fname = j.Element("Name").Value;
                        fname = SanitizeFileName(fname);

                        foreach (var i in EngineData)
                        {
                            sName = i.Element("ControlName").Value.ToString();

                            if (sName == "VirtualThrottle" || sName == "ThrottleAndBrake" || sName == "Regulator" || sName == "CabThrottle" || sName == "VirtualBrake" || sName == "VirtualTrainBrakeControl" || sName == "TrainBrakeControl" || sName == "EngineBrakeControl"
                                || sName == "VirtualEngineBrakeControl" || sName == "M8Brake" || sName == "DynamicBrake" || sName == "VirtualBynamicBrake" || sName == "Reverser" || sName == "VirtualReverser" || sName == "CabReverser" || sName == "Wipers"
                                || sName == "WiperSpeed" || sName == "swDriverWiper" || sName == "DriverWiper" || sName == "Headlights" || sName == "HeadlightSwitch" || sName == "VirtualHeadlights" || sName == "TaillightSwitch" || sName == "MarkerLightSwitch")
                            {
                                var NotchData = i.Descendants("InterfaceElements").Descendants("Notch").Descendants("cControlContainerBlueprint-cInteriorIrregularNotchedLever-cNotchData");
                                var ExtendedNotchData = i.Descendants("InterfaceElements").Descendants("Notch").Descendants("cControlContainerBlueprint-cInteriorIrregularNotchedLever-cExtendedNotchData");
                                var NumberOfNotchesData = i.Descendants("InterfaceElements").Descendants("cControlContainerBlueprint-cInteriorNotchedLever");

                                //**Reading EngineData
                                s += sName + " {";

                                foreach (var k in NotchData)
                                {
                                    s += Math.Round(float.Parse(k.Element("Value").Value), 3) + ", ";
                                }
                                foreach (var l in ExtendedNotchData)
                                {
                                    s += Math.Round(float.Parse(l.Element("Value").Value), 3) + ", ";
                                }
                                foreach (var h in NumberOfNotchesData)
                                {
                                    s += h.Element("NumberOfNotches").Value + ", ";
                                }
                                if (s.EndsWith(", ")) s = s.Remove(s.Length - 2, 2);
                                s += " }" + Environment.NewLine;
                            }

                        } 
                        
                    }
                    foreach (var scriptName in EngineScript)
                    {
                        string tmp = "Engine Script to edit = " + scriptName.Element("Name").Value.ToString() + Environment.NewLine;
                        s = tmp + s;
                    }

                    saveEngineData(fname, s, false);
                    s = "";

                    foreach (var j in EngineDataName)
                    {
                        fname = j.Element("Name").Value;
                        fname = SanitizeFileName(fname);

                        foreach (var i in EngineData)
                        {
                            sName = i.Element("ControlName").Value.ToString();
                            var NotchData = i.Descendants("InterfaceElements").Descendants("Notch").Descendants("cControlContainerBlueprint-cInteriorIrregularNotchedLever-cNotchData");
                            var ExtendedNotchData = i.Descendants("InterfaceElements").Descendants("Notch").Descendants("cControlContainerBlueprint-cInteriorIrregularNotchedLever-cExtendedNotchData");
                            var NumberOfNotchesData = i.Descendants("InterfaceElements").Descendants("cControlContainerBlueprint-cInteriorNotchedLever");

                            //**Reading EngineData
                            s += ("CONTROL NAME \"(" + sName + ")\",").PadRight(55, ' ');
                            s += ("MIN VALUE \"(" + i.Element("MinimumValue").Value + ")\",").PadRight(25, ' ');
                            s += ("MAX VALUE \"(" + i.Element("MaximumValue").Value + ")\",").PadRight(25, ' ');
                            s += "DEFAULT VALUE \"(" + i.Element("DefaultValue").Value + ")\"" + Environment.NewLine;
                            foreach (var k in NotchData)
                            {
                                s += ("  Notch Name \"(" + k.Element("Identifier").Value + ")\",").PadRight(55, ' ');
                                s += "Notch Value \"(" + k.Element("Value").Value + ")\"" + Environment.NewLine;
                            }
                            foreach (var l in ExtendedNotchData)
                            {
                                s += ("  Notch Name \"(" + l.Element("Identifier").Value + ")\",").PadRight(55, ' ');
                                s += "Notch Value \"(" + l.Element("Value").Value + ")\"" + Environment.NewLine;
                            }
                            foreach (var h in NumberOfNotchesData)
                            {
                                s += ("  Notch Name \"(Number of Notches)\",").PadRight(55, ' ');
                                s += "Notch Value \"(" + h.Element("NumberOfNotches").Value + ")\"" + Environment.NewLine;
                            }
                        }
                        foreach (var scriptName in EngineScript)
                        {
                            var tmp = "Engine Script to edit = " + scriptName.Element("Name").Value.ToString() + Environment.NewLine + Environment.NewLine;
                            s = tmp + s;
                        }
                        saveEngineData(fname, s, true);
                        s = "";
                    }
                }

                catch (Exception ex)
                {
                    MessageBox.Show("Error:- " + ex.Message);
                    throw;
                }
                if (chkShowExtractedData.Checked)
                {
                    //Show file to user using notepad
                    if (chkShowShortData.Checked)
                    {
                        if (File.Exists(Application.StartupPath + "\\ShortEngineData\\" + fname + ".txt"))
                        {
                            try
                            {
                                Process p = new System.Diagnostics.Process();
                                p.StartInfo.CreateNoWindow = true; // false;
                                p.StartInfo.ErrorDialog = true;
                                p.StartInfo.UseShellExecute = true;
                                p.StartInfo.FileName = Application.StartupPath + "\\ShortEngineData\\" + fname + ".txt";
                                p.Start();
                                p.WaitForExit();
                            }
                            catch (Exception)
                            {
                                MessageBox.Show("Error:-2 Are you sure you are opening a 'Engine Data' file");
                            }
                        }
                        else
                        {
                            MessageBox.Show("Error:- Unable to Process the file" + Environment.NewLine + "Are you sure you are opening a 'Engine Data' file");
                        }
                    }
                    else
                    {
                        if (File.Exists(Application.StartupPath + "\\FullEngineData\\" + fname + ".txt"))
                        {
                            try
                            {
                                Process p = new System.Diagnostics.Process();
                                p.StartInfo.CreateNoWindow = true; // false;
                                p.StartInfo.ErrorDialog = true;
                                p.StartInfo.UseShellExecute = true;
                                p.StartInfo.FileName = Application.StartupPath + "\\FullEngineData\\" + fname + ".txt";
                                p.Start();
                                p.WaitForExit();
                            }
                            catch (Exception)
                            {
                                MessageBox.Show("Error:-2 Are you sure you are opening a 'Engine Data' file");
                            }
                        }
                        else
                        {
                            MessageBox.Show("Error:- Unable to Process the file" + Environment.NewLine + "Are you sure you are opening a 'Engine Data' file");
                        }
                    } 
                }
            }
        }

        private void btnEngineDataViewFile_Click(object sender, EventArgs e)
        {
            //Open a openfile gialog box to select file to open
            OpenFileDialog ofd = new OpenFileDialog(); 
            if (chkShowShortData.Checked)
            {
                if (Directory.Exists(appPath + @"\ShortEngineData\"))
                {
                    ofd.InitialDirectory = appPath + "\\ShortEngineData\\";
                }
                else
                {
                    ofd.InitialDirectory = appPath;
                }
            }
            else
            {
                if (Directory.Exists(appPath + @"\FullEngineData\"))
                {
                    ofd.InitialDirectory = appPath + "\\FullEngineData\\";
                }
                else
                {
                    ofd.InitialDirectory = appPath;
                }
            }
           
           
            ofd.Filter = "*txt files (*.txt)|*.txt";
            if (ofd.ShowDialog() == DialogResult.OK)
            {
                //Show file to user using notepad
                try
                {
                    Process p = new System.Diagnostics.Process();
                    p.StartInfo.CreateNoWindow = true;
                    p.StartInfo.ErrorDialog = true;
                    p.StartInfo.UseShellExecute = true;
                    p.StartInfo.FileName = ofd.FileName;
                    p.Start();
                    p.WaitForExit();
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Error:- " + ex.Message);
                    throw;
                }
            }
        }

        private void btnInputmapperFile_Click(object sender, EventArgs e)
        {
            //Open up a fileopen dialog box to allow user to select file to open
            OpenFileDialog ofd = new OpenFileDialog();
            ofd.Filter = "*bin files (*.bin)|*.bin";
            if (inputmapperDirectory == "")
            {
                ofd.InitialDirectory = railworksPath + @"\assets\";
            }
            else
            {
                ofd.InitialDirectory = inputmapperDirectory;
            }
            ofd.RestoreDirectory = true;

            if (ofd.ShowDialog() == DialogResult.OK)
            {
                filename = ofd.FileName;
                string filenameWithoutExtension = Path.GetFileNameWithoutExtension(filename);
                string fileDirectory = Path.GetDirectoryName(filename) + "\\";
                inputmapperDirectory = fileDirectory;
                string fname = "";
                //Call serz.exe in railworks folder to extract loaded bin file to xml file
                try
                {
                    if (File.Exists(railworksPath + @"\serz.exe"))
                    {
                        Process p = new System.Diagnostics.Process();
                        p.StartInfo.CreateNoWindow = true; // false;
                        p.StartInfo.ErrorDialog = true;
                        p.StartInfo.UseShellExecute = false;// true;
                        p.StartInfo.FileName = railworksPath + "\\serz.exe";
                        p.StartInfo.Arguments = " \"" + filename + "\"";
                        p.Start();
                        p.WaitForExit(); 
                    }
                    else
                    {
                        MessageBox.Show("This program requires the file serz.exe to extract the data\r\nThis file does not exist in " + railworksPath
                            + "\r\nPlease select the \'Reset Railworks Path\' button and browse to your railworks.exe file", "Serz.exe Not Found");
                        return;
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Error:- " + ex.Message);
                    throw;
                }
                //Now extract data from the XML file we just extracted
                doc = XDocument.Load(fileDirectory + filenameWithoutExtension + ".xml");
                var InputMapperName = doc.Descendants("cInputMapperBlueprint");
                var inputMapper = doc.Descendants("iInputMapper-cInputMapEntry");
                File.Delete(fileDirectory + filenameWithoutExtension + ".xml");
                try
                {
                    foreach (var j in InputMapperName)
                    {
                        fname = j.Element("RemapperName").Value;
                        s = "CONTROL".PadRight(30, ' ') + "MAIN KEY".PadRight(20, ' ') + "EXTRA KEYS".PadRight(20, ' ') + "FUNCTION".PadRight(30, ' ') + "STATE" + Environment.NewLine;
                        foreach (var i in inputMapper)
                        {
                            ////**Reading inputmappers
                            s += (i.Element("Parameter").Value).PadRight(30, ' ');
                            s += (i.Element("Button").Value).PadRight(20, ' ');
                            s += (i.Element("ShiftButton").Value).PadRight(20, ' ');
                            s += (i.Element("Name").Value).PadRight(30, ' ');
                            s += (i.Element("ButtonState").Value) + Environment.NewLine;

                        }
                        saveInputmapper(fname, s);
                        s = "";
                    }
                }
                catch (Exception)
                {
                    MessageBox.Show("Error:- Are you sure you are opening a 'Inputmapper' file");
                    
                }
                if (chkShowExtractedData.Checked)
                {
                    //Show file to user using notepad
                    if (File.Exists(Application.StartupPath + @"\Inputmapper\" + fname + ".txt"))
                    {
                        try
                        {
                            Process p = new System.Diagnostics.Process();
                            p.StartInfo.CreateNoWindow = true; // false;
                            p.StartInfo.ErrorDialog = true;
                            p.StartInfo.UseShellExecute = true;
                            p.StartInfo.FileName = Application.StartupPath + @"\Inputmapper\" + fname + ".txt";
                            p.Start();
                            p.WaitForExit();
                        }
                        catch (Exception)
                        {
                            MessageBox.Show("Error:-2 Are you sure you are opening a 'Inputmapper' file");
                        }
                    }
                    else
                    {
                        MessageBox.Show("Error:- Unable to Process the file" + Environment.NewLine + "Are you sure you are opening a 'Inputmapper' file");
                    } 
                }
            }
        }

        private void btnInputmapperViewFile_Click(object sender, EventArgs e)
        {
            //Open a openfile gialog box to select file to open
            OpenFileDialog ofd = new OpenFileDialog();
            if (Directory.Exists(appPath + @"\Inputmapper\"))
            {
                ofd.InitialDirectory = appPath + "\\Inputmapper\\";
            }
            else
            {
                ofd.InitialDirectory = appPath;
            }
            ofd.Filter = "*txt files (*.txt)|*.txt";
            if (ofd.ShowDialog() == DialogResult.OK)
            {
                //Show file to user using notepad
                try
                {
                    Process p = new System.Diagnostics.Process();
                    p.StartInfo.CreateNoWindow = true;
                    p.StartInfo.ErrorDialog = true;
                    p.StartInfo.UseShellExecute = true;
                    p.StartInfo.FileName = ofd.FileName;
                    p.Start();
                    p.WaitForExit();
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Error:- " + ex.Message);
                    throw;
                }
            }
        }

        private void btnExit_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void saveEngineData(string f, string s, bool b)
        {
            string myFolder = "";
            //**Check if FullEnginData or ShortEngineData folders exists inside app folder
            //** if not then create them to store extracted xml files
            if (b)
            {
                myFolder = Application.StartupPath + @"\FullEngineData";
            }
            else
            {
                myFolder = Application.StartupPath + @"\ShortEngineData";
            }
            if (!Directory.Exists(myFolder))
            {
                //**Create the folder
                Directory.CreateDirectory(myFolder);
            }

            StreamWriter sr = new StreamWriter(myFolder + @"\" + f + ".txt");
            sr.Write(s);
            sr.Close();
        }

        private void saveInputmapper(string f, string s)
        {
            //**Check if Inputmapper folder exists inside app folder
            //** if not then create it to store extracted xml files
            string myfolder = Application.StartupPath + "\\Inputmapper";
            if (!Directory.Exists(myfolder))
            {
                //**Create the folder
                Directory.CreateDirectory(myfolder);
            }

            StreamWriter sr = new StreamWriter(myfolder + @"\" + f + ".txt");
            sr.Write(s);
            sr.Close();
        }

        private void loadSettings()
        {
            if (File.Exists(appPath + @"\settings.txt"))
            {
                using (StreamReader sr = new StreamReader(appPath + @"\settings.txt"))
                {
                    railworksPath = sr.ReadLine();
                }
            }
        }

        private void saveSettings()
        {
            try
            {
                using (StreamWriter sw = new StreamWriter(appPath + @"\settings.txt"))
                {
                    sw.Write(railworksPath);
                    sw.Close();
                }
            }
            catch (Exception e)
            {
                MessageBox.Show(e.ToString());
            }
        }

        private void checkRailworksPath()
        {

            if (railworksPath == "")
            {
                railworksPath = (string)Microsoft.Win32.Registry.GetValue(@"HKEY_LOCAL_MACHINE\SOFTWARE\railsimulator.com\railworks\", "Install_Path", "NOT Present");
            }
            bool b = false;
            if (railworksPath == "NOT Present")
            {
                //MessageBox.Show("The path to your railworks folder was not found" + Environment.NewLine + "you will need to enter it manually now" + Environment.NewLine 
                    //+ "by selecting the railworks.exe file", "Serz.exe not found");
                MessageBox.Show("The path to your railworks folder was not found\r\nyou will need to enter it manually now\r\nby selecting the railworks.exe file"
                    , "Serz.exe Not Found");
                OpenFileDialog ofd = new OpenFileDialog();
                ofd.Filter = "*exe files (*.exe)|*.exe";
                ofd.InitialDirectory = @"C:\";
                ofd.RestoreDirectory = true;

                while (b == false)
                {
                    if (ofd.ShowDialog() == DialogResult.OK)
                    {
                        //Check a valid file was found
                        if (Directory.Exists(Path.GetDirectoryName( ofd.FileName)))
                        //if (Path.GetFileName(ofd.FileName).ToLower() == "railworks.exe")
                        {
                            railworksPath = Path.GetDirectoryName(ofd.FileName) + @"\";
                            MessageBox.Show("Railworks found at " + railworksPath);
                            b = true;
                            return;
                        }
                        else
                        {
                            MessageBox.Show("Railworks.exe was not found in\r\n " + ofd.FileName + @"\");
                        }

                    }
                    else //user cancelled no valid path entered
                    {
                        railworksPath = "";
                        b = true;
                        MessageBox.Show("Without a valid path to railworks.exe this program will not run");
                        this.Close();
                    }
                }
                this.Close();
            }
            else //Path found in registry or in settings
            {
                if (File.Exists(railworksPath + @"\railworks.exe"))
                {
                    DialogResult dr = new DialogResult();
                    dr = MessageBox.Show(this, "Railworks was found in \r\n" + railworksPath + "\r\n Is this correct", "railWorks Location", MessageBoxButtons.YesNoCancel, MessageBoxIcon.Question);
                    if (dr == DialogResult.No)
                    {
                        //railWorksPath = (string)Microsoft.Win32.Registry.GetValue(@"HKEY_LOCAL_MACHINE\SOFTWARE\railsimulator.com\railworks\", "Install_Path", "NOT Present");
                        OpenFileDialog ofd = new OpenFileDialog();
                        //ofd.InitialDirectory = railWorksPath;
                        //if (railWorksPath == "NOT Present")
                        //{
                        string tmpPath = railworksPath;
                        railworksPath = "";
                        ofd.InitialDirectory = @"C:\";
                        //}

                        ofd.Filter = "*exe files (*.exe)|*.exe";
                        ofd.RestoreDirectory = true;

                        while (b == false)
                        {
                            dr = ofd.ShowDialog();
                            if (dr == DialogResult.OK)
                            {
                                //Check a valid file was found
                                //if (Directory.Exists(Path.GetDirectoryName( ofd.FileName)))
                                if (Path.GetFileName(ofd.FileName).ToLower() == "railworks.exe")
                                {
                                    railworksPath = Path.GetDirectoryName(ofd.FileName);
                                    MessageBox.Show("Railworks location set to\r\n " + railworksPath);
                                    b = true;
                                }
                                else
                                {
                                    MessageBox.Show("Railworks.exe was not found in\r\n " + Path.GetDirectoryName(ofd.FileName) + @"\" + "\r\nPlease try again");
                                }

                            }
                            else if (dr == DialogResult.Cancel)
                            {
                                b = true;
                                if (tmpPath == "")
                                {
                                    MessageBox.Show("Without a valid path to railworks.exe this program will not run");
                                    b = true;
                                    this.Close();
                                }
                                else //Restore original path
                                {
                                    railworksPath = tmpPath;
                                    b = true;
                                    MessageBox.Show("Path reset to " + railworksPath);
                                }
                                //MessageBox.Show("Raildriver path is set to\r\n" + railWorksPath);

                            }
                        }
                        if (railworksPath == "")
                        {
                            MessageBox.Show("Without a valid path to railworks.exe this program will not run");
                            this.Close();
                        }
                    }
                }
                else //serz.exe not found
                {
                    MessageBox.Show(railworksPath + "\r\ndoes not contain the railworks.exe file\r\n Please select the \'Re-enter Railworks Location\' option on the main form", "Serz.exe Not Found");
                    railworksPath = "";
                }
            }
        }

        private void btnResetRailworksPath_Click(object sender, EventArgs e)
        {
            checkRailworksPath();
        }

        private void Form1_FormClosing(object sender, FormClosingEventArgs e)
        {
            saveSettings();
        }
    }
}
