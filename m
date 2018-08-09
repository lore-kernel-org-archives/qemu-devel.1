Received: from eggs.gnu.org ([2001:4830:134:3::10]:32828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fno9o-0006KG-8S
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 12:51:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fno9n-0004EK-6I
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 12:51:28 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:37519)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <whois.zihan.yang@gmail.com>)
	id 1fno9m-0004Dc-Ub
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 12:51:27 -0400
Received: by mail-lf1-x144.google.com with SMTP id j8-v6so4595331lfb.4
	for <qemu-devel@nongnu.org>; Thu, 09 Aug 2018 09:51:26 -0700 (PDT)
MIME-Version: 1.0
References: <1533796115-15837-1-git-send-email-whois.zihan.yang@gmail.com>
In-Reply-To: <1533796115-15837-1-git-send-email-whois.zihan.yang@gmail.com>
From: Zihan Yang <whois.zihan.yang@gmail.com>
Date: Fri, 10 Aug 2018 00:51:13 +0800
Message-ID: <CAKwiv-gGke=3RyrCikiU6bMofFDn6YVJ1SeWTDF=92Qk7U+Eew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC v4 0/6] pci_expander_brdige: Support pxb-pcie
 host bridge into separate pci domain
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, eblake@redhat.com

HI all,

Sorry about unthreaded messages, I forgot to add the in-reply-to field in
the email. Future
patches will be threaded, but as for this patch, you can refer to the
following links
[RFC 1/6]
http://lists.nongnu.org/archive/html/qemu-devel/2018-08/msg01364.html
[RFC 2/6]
http://lists.nongnu.org/archive/html/qemu-devel/2018-08/msg01365.html
[RFC 3/6]
http://lists.nongnu.org/archive/html/qemu-devel/2018-08/msg01366.html
[RFC 4/6]
http://lists.nongnu.org/archive/html/qemu-devel/2018-08/msg01367.html
[RFC 5/6]
http://lists.nongnu.org/archive/html/qemu-devel/2018-08/msg01368.html
[RFC 6/6]
http://lists.nongnu.org/archive/html/qemu-devel/2018-08/msg01369.html

P.S. The "current issue" section of last email is resolved now, but there
are other issues.
I will see if I can work them out in the weekend and prepare for a v3 patch
of seabios (and
maybe v5 of qemu).

Thanks
Zihan
