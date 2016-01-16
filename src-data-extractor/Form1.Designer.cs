namespace Data_Extractor
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.btnEngineDataFile = new System.Windows.Forms.Button();
            this.btnEngineDataViewFile = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.btnInputmapperViewFile = new System.Windows.Forms.Button();
            this.btnInputmapperFile = new System.Windows.Forms.Button();
            this.splitContainer1 = new System.Windows.Forms.SplitContainer();
            this.chkShowShortData = new System.Windows.Forms.CheckBox();
            this.btnExit = new System.Windows.Forms.Button();
            this.chkShowExtractedData = new System.Windows.Forms.CheckBox();
            this.btnResetRailworksPath = new System.Windows.Forms.Button();
            this.splitContainer1.Panel1.SuspendLayout();
            this.splitContainer1.Panel2.SuspendLayout();
            this.splitContainer1.SuspendLayout();
            this.SuspendLayout();
            // 
            // btnEngineDataFile
            // 
            this.btnEngineDataFile.Location = new System.Drawing.Point(25, 45);
            this.btnEngineDataFile.Name = "btnEngineDataFile";
            this.btnEngineDataFile.Size = new System.Drawing.Size(75, 23);
            this.btnEngineDataFile.TabIndex = 0;
            this.btnEngineDataFile.Text = "Extract File";
            this.btnEngineDataFile.UseVisualStyleBackColor = true;
            this.btnEngineDataFile.Click += new System.EventHandler(this.btnEngineDataFile_Click);
            // 
            // btnEngineDataViewFile
            // 
            this.btnEngineDataViewFile.Location = new System.Drawing.Point(25, 100);
            this.btnEngineDataViewFile.Name = "btnEngineDataViewFile";
            this.btnEngineDataViewFile.Size = new System.Drawing.Size(75, 23);
            this.btnEngineDataViewFile.TabIndex = 1;
            this.btnEngineDataViewFile.Text = "View File";
            this.btnEngineDataViewFile.UseVisualStyleBackColor = true;
            this.btnEngineDataViewFile.Click += new System.EventHandler(this.btnEngineDataViewFile_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(34, 11);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(66, 13);
            this.label1.TabIndex = 3;
            this.label1.Text = "Engine Data";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(38, 11);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(66, 13);
            this.label2.TabIndex = 3;
            this.label2.Text = "Inputmapper";
            // 
            // btnInputmapperViewFile
            // 
            this.btnInputmapperViewFile.Location = new System.Drawing.Point(29, 100);
            this.btnInputmapperViewFile.Name = "btnInputmapperViewFile";
            this.btnInputmapperViewFile.Size = new System.Drawing.Size(75, 23);
            this.btnInputmapperViewFile.TabIndex = 1;
            this.btnInputmapperViewFile.Text = "View File";
            this.btnInputmapperViewFile.UseVisualStyleBackColor = true;
            this.btnInputmapperViewFile.Click += new System.EventHandler(this.btnInputmapperViewFile_Click);
            // 
            // btnInputmapperFile
            // 
            this.btnInputmapperFile.Location = new System.Drawing.Point(28, 45);
            this.btnInputmapperFile.Name = "btnInputmapperFile";
            this.btnInputmapperFile.Size = new System.Drawing.Size(75, 23);
            this.btnInputmapperFile.TabIndex = 0;
            this.btnInputmapperFile.Text = "Extract File";
            this.btnInputmapperFile.UseVisualStyleBackColor = true;
            this.btnInputmapperFile.Click += new System.EventHandler(this.btnInputmapperFile_Click);
            // 
            // splitContainer1
            // 
            this.splitContainer1.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.splitContainer1.Location = new System.Drawing.Point(12, 41);
            this.splitContainer1.Name = "splitContainer1";
            // 
            // splitContainer1.Panel1
            // 
            this.splitContainer1.Panel1.Controls.Add(this.chkShowShortData);
            this.splitContainer1.Panel1.Controls.Add(this.label1);
            this.splitContainer1.Panel1.Controls.Add(this.btnEngineDataFile);
            this.splitContainer1.Panel1.Controls.Add(this.btnEngineDataViewFile);
            // 
            // splitContainer1.Panel2
            // 
            this.splitContainer1.Panel2.Controls.Add(this.label2);
            this.splitContainer1.Panel2.Controls.Add(this.btnInputmapperViewFile);
            this.splitContainer1.Panel2.Controls.Add(this.btnInputmapperFile);
            this.splitContainer1.Size = new System.Drawing.Size(290, 151);
            this.splitContainer1.SplitterDistance = 143;
            this.splitContainer1.TabIndex = 4;
            // 
            // chkShowShortData
            // 
            this.chkShowShortData.AutoSize = true;
            this.chkShowShortData.Location = new System.Drawing.Point(3, 77);
            this.chkShowShortData.Name = "chkShowShortData";
            this.chkShowShortData.Size = new System.Drawing.Size(117, 17);
            this.chkShowShortData.TabIndex = 4;
            this.chkShowShortData.Text = "Show Minimal Data";
            this.chkShowShortData.UseVisualStyleBackColor = true;
            // 
            // btnExit
            // 
            this.btnExit.Location = new System.Drawing.Point(189, 223);
            this.btnExit.Name = "btnExit";
            this.btnExit.Size = new System.Drawing.Size(75, 23);
            this.btnExit.TabIndex = 5;
            this.btnExit.Text = "Exit";
            this.btnExit.UseVisualStyleBackColor = true;
            this.btnExit.Click += new System.EventHandler(this.btnExit_Click);
            // 
            // chkShowExtractedData
            // 
            this.chkShowExtractedData.AutoSize = true;
            this.chkShowExtractedData.Checked = true;
            this.chkShowExtractedData.CheckState = System.Windows.Forms.CheckState.Checked;
            this.chkShowExtractedData.Location = new System.Drawing.Point(17, 223);
            this.chkShowExtractedData.Name = "chkShowExtractedData";
            this.chkShowExtractedData.Size = new System.Drawing.Size(120, 17);
            this.chkShowExtractedData.TabIndex = 6;
            this.chkShowExtractedData.Text = "Show Extracted File";
            this.chkShowExtractedData.UseVisualStyleBackColor = true;
            // 
            // btnResetRailworksPath
            // 
            this.btnResetRailworksPath.Location = new System.Drawing.Point(89, 12);
            this.btnResetRailworksPath.Name = "btnResetRailworksPath";
            this.btnResetRailworksPath.Size = new System.Drawing.Size(132, 23);
            this.btnResetRailworksPath.TabIndex = 7;
            this.btnResetRailworksPath.Text = "Reset Railworks Path";
            this.btnResetRailworksPath.UseVisualStyleBackColor = true;
            this.btnResetRailworksPath.Click += new System.EventHandler(this.btnResetRailworksPath_Click);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(317, 258);
            this.Controls.Add(this.btnResetRailworksPath);
            this.Controls.Add(this.chkShowExtractedData);
            this.Controls.Add(this.btnExit);
            this.Controls.Add(this.splitContainer1);
            this.MaximizeBox = false;
            this.MaximumSize = new System.Drawing.Size(333, 297);
            this.MinimizeBox = false;
            this.MinimumSize = new System.Drawing.Size(333, 297);
            this.Name = "Form1";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "TrainSim Helper Data Extractor, Version 0.6";
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.Form1_FormClosing);
            this.Load += new System.EventHandler(this.Form1_Load);
            this.splitContainer1.Panel1.ResumeLayout(false);
            this.splitContainer1.Panel1.PerformLayout();
            this.splitContainer1.Panel2.ResumeLayout(false);
            this.splitContainer1.Panel2.PerformLayout();
            this.splitContainer1.ResumeLayout(false);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button btnEngineDataFile;
        private System.Windows.Forms.Button btnEngineDataViewFile;
        private System.Windows.Forms.Button btnInputmapperViewFile;
        private System.Windows.Forms.Button btnInputmapperFile;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.SplitContainer splitContainer1;
        private System.Windows.Forms.Button btnExit;
        private System.Windows.Forms.CheckBox chkShowShortData;
        private System.Windows.Forms.CheckBox chkShowExtractedData;
        private System.Windows.Forms.Button btnResetRailworksPath;
    }
}

