Received: from eggs.gnu.org ([2001:4830:134:3::10]:47431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gK3f5-0005gz-Vk
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 10:53:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gK3f2-0006yU-Dr
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 10:53:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1gK3f2-0006sM-6N
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 10:53:00 -0500
Date: Tue, 6 Nov 2018 15:52:57 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20181106155257.GB14842@redhat.com>
References: <ae2d0fbd-5198-47e8-9ad2-40a85f0b3576@default>
	<bd913c1b-fcbe-b198-3955-4b4b2e33757a@redhat.com>
	<fef3b167-0d69-d61d-418b-535fb6d36dfc@oracle.com>
	<20181106091457.GC4080@redhat.com>
	<20181106094306.GA14842@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106094306.GA14842@redhat.com>
Subject: Re: [Qemu-devel] [Libguestfs] How to emulate block I/O timeout on
 qemu side?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: jsnow@redhat.com, qemu-devel@nongnu.org, libguestfs <libguestfs@redhat.com>

On Tue, Nov 06, 2018 at 09:43:06AM +0000, Richard W.M. Jones wrote:
> On Tue, Nov 06, 2018 at 09:14:57AM +0000, Richard W.M. Jones wrote:
> > This link shows how to combine delay and error filters together:
> > 
> >   https://rwmj.wordpress.com/2018/11/04/nbd-graphical-viewer/
> 
> Oops, that's in a forthcoming blog post not this one.  Not enough
> caffeine this morning.

Up now:

https://rwmj.wordpress.com/2018/11/06/nbd-graphical-viewer-raid-5-edition/

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org
