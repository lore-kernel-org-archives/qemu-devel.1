Received: from eggs.gnu.org ([2001:4830:134:3::10]:48729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d7imQ-00045K-KB
	for qemu-devel@nongnu.org; Mon, 08 May 2017 09:32:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d7imP-0007gX-Qx
	for qemu-devel@nongnu.org; Mon, 08 May 2017 09:32:50 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:36680)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1d7imP-0007ff-Kd
	for qemu-devel@nongnu.org; Mon, 08 May 2017 09:32:49 -0400
Received: by mail-wm0-x235.google.com with SMTP id u65so84897590wmu.1
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 06:32:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAEfK_44j8k3Jiqp7LbXNasKjcfTT0uPPAbyPN=xg=HDAk0WoRQ@mail.gmail.com>
References: <CAEfK_46MMR6cH3ahuJ=zfcuKAp07iU20Ps+yZYv5s9woCPnsSw@mail.gmail.com>
	<20170502142207.GJ22502@stefanha-x1.localdomain>
	<CAEfK_46hGYYpO4YhYcxdUar1ugLQwbpJMgxAJDJU13zSpbD4zw@mail.gmail.com>
	<20170505144506.GA14316@stefanha-x1.localdomain>
	<CAEfK_44TpSJVi7JULXMRLftM5BFUJs=vHSxKG3h=YOUjQz1t+g@mail.gmail.com>
	<CAJSP0QV++8rKxPrAXv1GWrwtiK4CNZCv+QoSzYkG-1LYF2SEgw@mail.gmail.com>
	<CAEfK_44j8k3Jiqp7LbXNasKjcfTT0uPPAbyPN=xg=HDAk0WoRQ@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 8 May 2017 09:32:47 -0400
Message-ID: <CAJSP0QWS_WgShRm7cH-M3+B3rwCgQi9j_u2ZtmZk4vc5-fMRbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] gdbstub: implement remote debugging
 protocol escapes for command receive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Doug Gale <doug16k@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

I applied this patch manually because it was not formatted according
to the patch submission guidelines.  Please take note of them for
future contributions:

1. "Send each new revision as a new top-level thread, rather than
burying it in-reply-to an earlier revision, as many reviewers are not
looking inside deep threads for new patches."

2. Revision changelog or comments that should not go into git history
must be below '---'.  This way git-am(1) can apply your mail in a
single command.

Thanks,
Stefan
