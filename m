Received: from eggs.gnu.org ([2001:4830:134:3::10]:49522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cyEm1-00034J-GU
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 05:41:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cyEly-00021W-CL
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 05:41:13 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:34875)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1cyElx-000205-Uk
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 05:41:10 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <BM1PR01MB0722F734DE63EB1274B3132B84000@BM1PR01MB0722.INDPRD01.PROD.OUTLOOK.COM>
References: <BM1PR01MB072283BB7A3BC4BB287D35A784010@BM1PR01MB0722.INDPRD01.PROD.OUTLOOK.COM>
	<BM1PR01MB07224A0D4D1815F66D26EB7C84010@BM1PR01MB0722.INDPRD01.PROD.OUTLOOK.COM>
	<20170411075348.GA4516@noname.str.redhat.com>
	<BM1PR01MB0722AC7132DBFA648D3732A084000@BM1PR01MB0722.INDPRD01.PROD.OUTLOOK.COM>
	<BM1PR01MB0722F734DE63EB1274B3132B84000@BM1PR01MB0722.INDPRD01.PROD.OUTLOOK.COM>
Date: Wed, 12 Apr 2017 11:41:07 +0200
Message-ID: <w51k26qj74c.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Fw: First contribution - Interested in Outreachy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Prerna Garg <Prerna.Garg@live.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On Tue 11 Apr 2017 06:44:33 PM CEST, Prerna Garg wrote:

> I am having difficulties sending the email through command line. So as
> a last resort I am sending the patch as an attachment.

Hi!

what is the exact problem? Once you commit your patch, can you export it
correctly to a file using "git format-patch" ?

After that you can simply write something like

git send-email --to="qemu-devel@nongnu.org" --cc="Alberto Garcia <berto@igalia.com>" patch-file.patch

Berto
