Received: from eggs.gnu.org ([2001:4830:134:3::10]:54677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cxqcg-0002gR-OW
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 03:53:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cxqcb-0005YJ-U7
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 03:53:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34736)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1cxqcb-0005XM-OQ
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 03:53:53 -0400
Date: Tue, 11 Apr 2017 09:53:48 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170411075348.GA4516@noname.str.redhat.com>
References: <BM1PR01MB072283BB7A3BC4BB287D35A784010@BM1PR01MB0722.INDPRD01.PROD.OUTLOOK.COM>
	<BM1PR01MB07224A0D4D1815F66D26EB7C84010@BM1PR01MB0722.INDPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BM1PR01MB07224A0D4D1815F66D26EB7C84010@BM1PR01MB0722.INDPRD01.PROD.OUTLOOK.COM>
Subject: Re: [Qemu-devel] First contribution - Interested in Outreachy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Prerna Garg <Prerna.Garg@live.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "stefanha@redhat.com" <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>

Hi Prerna,

Am 10.04.2017 um 21:59 hat Prerna Garg geschrieben:
> The previous patch was incorrect. Sorry for the inconvenience. Please consider
> this as my first contribution. 

Please read this wiki page about how to submit patches to QEMU:

    http://wiki.qemu-project.org/Contribute/SubmitAPatch

The most important point that is missing from your patch is the
Signed-off-by line, without which a patch cannot be accepted.

You should also try to have a commit message (including the subject
line) that describes the change that your patch is making, and include
[PATCH] in your subject line. If you use 'git format-patch' to create
the email, the [PATCH] is added automatically.

Kevin
