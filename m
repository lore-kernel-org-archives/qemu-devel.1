Received: from eggs.gnu.org ([2001:4830:134:3::10]:35218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1eF5Yw-0005kl-Ne
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 16:49:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1eF5Yv-0003mm-R9
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 16:49:38 -0500
Date: Wed, 15 Nov 2017 21:49:27 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20171115214927.GO2787@redhat.com>
References: <CAJH6TXhBAaBE9gBSxksWZqNywWmencRaGyeY-oN3jbKdgUettQ@mail.gmail.com>
	<0e6cc220-814a-17fd-4fd7-7b0665d34e81@redhat.com>
	<CAJH6TXh2v-F=yqxQbUUawk_Ctq-sgFefGp1XvMsC=syX_5jEqA@mail.gmail.com>
	<30b54865-2255-d13d-a054-afcf5bbd06b2@redhat.com>
	<20171115202440.GJ19514@redhat.com>
	<7b11bb2b-b93d-e8ff-f396-703c93549d0d@redhat.com>
	<20171115202938.GN2787@redhat.com>
	<CAJH6TXiPuLu62-+o2+PrUGpstrks_5pLotFEe1bAOmsbn20otw@mail.gmail.com>
	<5b6f8758-5e3e-e759-1592-2768eb85b322@redhat.com>
	<CAJH6TXgrOWxP7jFg98_jv-R1nrFKOXBQA6pPxbkzGWTVW=EReA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJH6TXgrOWxP7jFg98_jv-R1nrFKOXBQA6pPxbkzGWTVW=EReA@mail.gmail.com>
Subject: Re: [Qemu-devel] [Libguestfs]  [qemu-img] support for XVA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: Max Reitz <mreitz@redhat.com>, Qemu-block <qemu-block@nongnu.org>, qemu-devel@nongnu.org, libguestfs <libguestfs@redhat.com>

On Wed, Nov 15, 2017 at 10:42:42PM +0100, Gandalf Corvotempesta wrote:
> I'm thinking on how to prove you a sample XVA
> I have to create (and populate) a VM because an empty image will result in
> an empty XVA
> And a VM is 300-400Mb as minimum

That's fine to download.  Also you could compress it (for transfer)
which should make it smaller.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org
