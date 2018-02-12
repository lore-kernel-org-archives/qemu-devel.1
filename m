Received: from eggs.gnu.org ([2001:4830:134:3::10]:39993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1elEJ5-0000bt-Le
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 08:38:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1elEJ0-0004mz-4h
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 08:38:07 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50430 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1elEIz-0004mI-UD
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 08:38:02 -0500
Date: Mon, 12 Feb 2018 14:37:44 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180212133744.GF5103@localhost.localdomain>
References: <20171012235439.19457-1-anatol.pomozov@gmail.com>
	<20171012235439.19457-2-anatol.pomozov@gmail.com>
	<20180115144944.GG32271@localhost.localdomain>
	<CAOMFOmU4pLtJMQ_SLqffpritydx4ghs9gUJBfyVT+zN_fudCRA@mail.gmail.com>
	<20180129200210.GT6141@localhost.localdomain>
	<CAOMFOmXrp8x18Jph8ipR+m52FxdjcpaLoHP_Xh-4F6X95pG+8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMFOmXrp8x18Jph8ipR+m52FxdjcpaLoHP_Xh-4F6X95pG+8Q@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 1/4] multiboot: Change multiboot_info from
 array of bytes to a C struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anatol Pomozov <anatol.pomozov@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Am 09.02.2018 um 22:48 hat Anatol Pomozov geschrieben:
> Hi Kevin
> 
> Is the patch series look good? Are there any other unresolved issues?

This is the email thread for the first version. No, it doesn't look
good.

In the thread for your second version, Jack had a few comments that you
didn't respond to yet.

Kevin
