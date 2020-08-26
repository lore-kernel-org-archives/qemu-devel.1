Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFFBC433E3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 07:49:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9247E20707
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 07:49:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9247E20707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAqBy-00067y-Ol
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 03:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kAqB5-0004Tl-6I; Wed, 26 Aug 2020 03:49:03 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2105 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kAqB2-0002Dp-MN; Wed, 26 Aug 2020 03:49:02 -0400
Received: from dggemi406-hub.china.huawei.com (unknown [172.30.72.56])
 by Forcepoint Email with ESMTP id C07CDB5BF5E871EB8FFC;
 Wed, 26 Aug 2020 15:48:57 +0800 (CST)
Received: from DGGEMI421-HUB.china.huawei.com (10.1.199.150) by
 dggemi406-hub.china.huawei.com (10.3.17.144) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Wed, 26 Aug 2020 15:48:57 +0800
Received: from DGGEMI522-MBS.china.huawei.com ([169.254.8.252]) by
 dggemi421-hub.china.huawei.com ([10.1.199.150]) with mapi id 14.03.0487.000;
 Wed, 26 Aug 2020 15:48:48 +0800
From: zhaolichang <zhaolichang@huawei.com>
To: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
Subject: [PATCH V2 10/10] contrib/: fix some comment spelling errors
Thread-Topic: [PATCH V2 10/10] contrib/: fix some comment spelling errors
Thread-Index: AdZ7fJ5t0Q3CdhebSvmANGpggTrYMA==
Date: Wed, 26 Aug 2020 07:48:47 +0000
Message-ID: <640CDEE67BE2784FAE298BB2517210E48AC436@dggemi522-mbs.china.huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.186.227]
Content-Type: multipart/alternative;
 boundary="_000_640CDEE67BE2784FAE298BB2517210E48AC436dggemi522mbschina_"
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.189;
 envelope-from=zhaolichang@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 03:47:14
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: zhaolichang <zhaolichang@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_640CDEE67BE2784FAE298BB2517210E48AC436dggemi522mbschina_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I found that there are many spelling errors in the comments of qemu,
so I used the spellcheck tool to check the spelling errors
and finally found some spelling errors in the contrib folder.

Signed-off-by: zhaolichang <zhaolichang@huawei.com>
Reviewed-by: Alex Benn=E9e <alex.bennee@linaro.org>
---
contrib/gitdm/filetypes.txt             | 6 +++---
contrib/ivshmem-client/ivshmem-client.h | 2 +-
contrib/libvhost-user/libvhost-user.c   | 4 ++--
contrib/libvhost-user/libvhost-user.h   | 2 +-
4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/contrib/gitdm/filetypes.txt b/contrib/gitdm/filetypes.txt
index 9e9c505205..d2d6f6db8d 100644
--- a/contrib/gitdm/filetypes.txt
+++ b/contrib/gitdm/filetypes.txt
@@ -22,7 +22,7 @@
# in the gitdm sample-config directory.
#
# This file contains associations parameters regarding filetypes
-# (documentation, develompent, multimedia, images...)
+# (documentation, development, multimedia, images...)
#
# format:
# filetype <type> <regex> [<comment>]
@@ -59,8 +59,8 @@ filetype code \.s$ # Assembly
filetype code \.S$     # Assembly
filetype code \.asm$        # Assembly
filetype code \.awk$         # awk
-filetype code ^common$  # script fragements
-filetype code ^common.*$  # script fragements
+filetype code ^common$  # script fragments
+filetype code ^common.*$  # script fragments
filetype code (qom|qmp)-\w+$  # python script fragments

#
diff --git a/contrib/ivshmem-client/ivshmem-client.h b/contrib/ivshmem-clie=
nt/ivshmem-client.h
index fe3cc4a03d..fc45a38060 100644
--- a/contrib/ivshmem-client/ivshmem-client.h
+++ b/contrib/ivshmem-client/ivshmem-client.h
@@ -174,7 +174,7 @@ int ivshmem_client_notify_all_vects(const IvshmemClient=
 *client,
                                     const IvshmemClientPeer *peer);

/**
- * Broadcat a notification to all vectors of all peers
+ * Broadcast a notification to all vectors of all peers
  *
  * @client: The ivshmem client
  *
diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/=
libvhost-user.c
index 53f16bdf08..9d30ff2283 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -684,7 +684,7 @@ vu_add_mem_reg(VuDev *dev, VhostUserMsg *vmsg) {

     /*
      * If we are in postcopy mode and we receive a u64 payload with a 0 va=
lue
-     * we know all the postcopy client bases have been recieved, and we
+     * we know all the postcopy client bases have been received, and we
      * should start generating faults.
      */
     if (track_ramblocks &&
@@ -973,7 +973,7 @@ vu_set_mem_table_exec(VuDev *dev, VhostUserMsg *vmsg)
     for (i =3D 0; i < dev->max_queues; i++) {
         if (dev->vq[i].vring.desc) {
             if (map_ring(dev, &dev->vq[i])) {
-                vu_panic(dev, "remaping queue %d during setmemtable", i);
+                vu_panic(dev, "remapping queue %d during setmemtable", i);
             }
         }
     }
diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-user/=
libvhost-user.h
index 844c37c648..287ac5fec7 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -424,7 +424,7 @@ typedef struct VuVirtqElement {
  * @remove_watch: a remove_watch callback
  * @iface: a VuDevIface structure with vhost-user device callbacks
  *
- * Intializes a VuDev vhost-user context.
+ * Initializes a VuDev vhost-user context.
  *
  * Returns: true on success, false on failure.
  **/
--
2.26.2.windows.1


--_000_640CDEE67BE2784FAE298BB2517210E48AC436dggemi522mbschina_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	font-family:"Calibri",sans-serif;}
/* Page Definitions */
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"ZH-CN" link=3D"#0563C1" vlink=3D"#954F72" style=3D"text-justi=
fy-trim:punctuation">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US">I found that there are many spe=
lling errors in the comments of qemu,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">so I used the spellcheck tool t=
o check the spelling errors<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">and finally found some spelling=
 errors in the contrib folder.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Signed-off-by: zhaolichang &lt;=
zhaolichang@huawei.com&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Reviewed-by: Alex Benn=E9e &lt;=
alex.bennee@linaro.org&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">---<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">contrib/gitdm/filetypes.txt&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 6 &#=
43;&#43;&#43;---<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">contrib/ivshmem-client/ivshmem-=
client.h | 2 &#43;-<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">contrib/libvhost-user/libvhost-=
user.c&nbsp;&nbsp; | 4 &#43;&#43;--<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">contrib/libvhost-user/libvhost-=
user.h&nbsp;&nbsp; | 2 &#43;-<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">4 files changed, 7 insertions(&=
#43;), 7 deletions(-)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/contrib/gitdm/file=
types.txt b/contrib/gitdm/filetypes.txt<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 9e9c505205..d2d6f6db8d 10=
0644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/contrib/gitdm/filetypes.t=
xt<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/contrib/gitdm=
/filetypes.txt<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -22,7 &#43;22,7 @@<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"># in the gitdm sample-config di=
rectory.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">#<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"># This file contains associatio=
ns parameters regarding filetypes<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-# (documentation, develompent,=
 multimedia, images...)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;# (documentation, developm=
ent, multimedia, images...)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">#<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"># format:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"># filetype &lt;type&gt; &lt;reg=
ex&gt; [&lt;comment&gt;]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -59,8 &#43;59,8 @@ filetype =
code \.s$ # Assembly<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">filetype code \.S$&nbsp;&nbsp;&=
nbsp;&nbsp; # Assembly<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">filetype code \.asm$&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # Assembly<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">filetype code \.awk$&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # awk<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-filetype code ^common$&nbsp; #=
 script fragements<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-filetype code ^common.*$&nbsp;=
 # script fragements<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;filetype code ^common$&nbs=
p; # script fragments<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;filetype code ^common.*$&n=
bsp; # script fragments<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">filetype code (qom|qmp)-\w&#43;=
$&nbsp; # python script fragments<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">#<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/contrib/ivshmem-cl=
ient/ivshmem-client.h b/contrib/ivshmem-client/ivshmem-client.h<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index fe3cc4a03d..fc45a38060 10=
0644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/contrib/ivshmem-client/iv=
shmem-client.h<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/contrib/ivshm=
em-client/ivshmem-client.h<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -174,7 &#43;174,7 @@ int ivs=
hmem_client_notify_all_vects(const IvshmemClient *client,<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const IvshmemClientPeer *peer);<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">/**<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">- * Broadcat a notification to =
all vectors of all peers<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43; * Broadcast a notificatio=
n to all vectors of all peers<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; *<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; * @client: The ivshmem c=
lient<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; *<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/contrib/libvhost-u=
ser/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 53f16bdf08..9d30ff2283 10=
0644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/contrib/libvhost-user/lib=
vhost-user.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/contrib/libvh=
ost-user/libvhost-user.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -684,7 &#43;684,7 @@ vu_add_=
mem_reg(VuDev *dev, VhostUserMsg *vmsg) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; /*<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
* If we are in postcopy mode and we receive a u64 payload with a 0 value<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-&nbsp;&nbsp;&nbsp;&nbsp; * we =
know all the postcopy client bases have been recieved, and we<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp; *=
 we know all the postcopy client bases have been received, and we<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
* should start generating faults.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; if (tr=
ack_ramblocks &amp;&amp;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -973,7 &#43;973,7 @@ vu_set_=
mem_table_exec(VuDev *dev, VhostUserMsg *vmsg)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; for (i=
 =3D 0; i &lt; dev-&gt;max_queues; i&#43;&#43;) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (dev-&gt;vq[i].vring.desc) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (map_ring(dev, &amp;dev-&gt;vq=
[i])) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vu_panic(dev, =
&quot;remaping queue %d during setmemtable&quot;, i);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vu_panic(d=
ev, &quot;remapping queue %d during setmemtable&quot;, i);<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; }<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/contrib/libvhost-u=
ser/libvhost-user.h b/contrib/libvhost-user/libvhost-user.h<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 844c37c648..287ac5fec7 10=
0644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/contrib/libvhost-user/lib=
vhost-user.h<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/contrib/libvh=
ost-user/libvhost-user.h<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -424,7 &#43;424,7 @@ typedef=
 struct VuVirtqElement {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; * @remove_watch: a remov=
e_watch callback<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; * @iface: a VuDevIface s=
tructure with vhost-user device callbacks<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; *<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">- * Intializes a VuDev vhost-us=
er context.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43; * Initializes a VuDev vho=
st-user context.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; *<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; * Returns: true on succe=
ss, false on failure.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; **/<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-- <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">2.26.2.windows.1<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>

--_000_640CDEE67BE2784FAE298BB2517210E48AC436dggemi522mbschina_--

