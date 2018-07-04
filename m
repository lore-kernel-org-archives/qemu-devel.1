Received: from eggs.gnu.org ([2001:4830:134:3::10]:45303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1faaZQ-0007vO-Jl
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 01:43:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1faaZM-0003BD-U7
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 01:43:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34954 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1faaZM-0003B3-PM
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 01:43:12 -0400
Date: Wed, 4 Jul 2018 08:43:08 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180704083924-mutt-send-email-mst@kernel.org>
References: <20180629221907.3662-1-venu.busireddy@oracle.com>
	<20180702161404.GA2339@rkaganb.sw.ru>
	<449f1449-ddf6-cd95-976c-14d04d8d503a@oracle.com>
	<20180703095825.GC30904@rkaganb.sw.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703095825.GC30904@rkaganb.sw.ru>
Subject: Re: [Qemu-devel] [PATCH v3 0/3] Use of unique identifier for
 pairing virtio and passthrough devices...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, si-wei liu <si-wei.liu@oracle.com>, Venu Busireddy <venu.busireddy@oracle.com>, Marcel Apfelbaum <marcel@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org

On Tue, Jul 03, 2018 at 12:58:25PM +0300, Roman Kagan wrote:
> > >    How is this supposed to work with legacy guests that don't support it?
> > Only PV device will be exposed on legacy guest.
> 
> So how is this coordination going to work?

Here's a description:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg538867.html

-- 
MST
