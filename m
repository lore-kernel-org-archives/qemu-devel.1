Received: from eggs.gnu.org ([2001:4830:134:3::10]:49842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cySgi-0005IJ-Fy
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 20:32:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cySgd-0008AZ-Jt
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 20:32:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36450)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cySgd-0008AN-DN
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 20:32:35 -0400
Date: Thu, 13 Apr 2017 08:32:29 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170413003229.GD8607@lemon>
References: <BM1PR01MB072283BB7A3BC4BB287D35A784010@BM1PR01MB0722.INDPRD01.PROD.OUTLOOK.COM>
	<BM1PR01MB07224A0D4D1815F66D26EB7C84010@BM1PR01MB0722.INDPRD01.PROD.OUTLOOK.COM>
	<20170411075348.GA4516@noname.str.redhat.com>
	<BM1PR01MB0722AC7132DBFA648D3732A084000@BM1PR01MB0722.INDPRD01.PROD.OUTLOOK.COM>
	<BM1PR01MB0722F734DE63EB1274B3132B84000@BM1PR01MB0722.INDPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BM1PR01MB0722F734DE63EB1274B3132B84000@BM1PR01MB0722.INDPRD01.PROD.OUTLOOK.COM>
Subject: Re: [Qemu-devel] Fw: First contribution - Interested in Outreachy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Prerna Garg <Prerna.Garg@live.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>

On Tue, 04/11 16:44, Prerna Garg wrote:
> 
> 
> 
> ________________________________
> From: Prerna Garg
> Sent: Tuesday, April 11, 2017 9:57 PM
> To: Kevin Wolf
> Subject: Re: First contribution - Interested in Outreachy
> 
> 
> Hello,
> 
> 
> I am having difficulties sending the email through command line. So as a last
> resort I am sending the patch as an attachment.

Hi Prerna,

If it is git-send-email that doesn't work, probably it's because you haven't
configured the email server info correctly. Follow the instructions of
git-send-email to point to the used SMTP server in you $HOME/.gitconfig: 

https://git-scm.com/docs/git-send-email

Let us know if you have any more difficulties.

Fam
