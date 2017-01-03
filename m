Received: from eggs.gnu.org ([2001:4830:134:3::10]:50639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cOLgN-0000gs-OO
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 04:47:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cOLgK-0002xZ-M2
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 04:47:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49980)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cOLgK-0002xU-G8
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 04:47:00 -0500
Date: Tue, 3 Jan 2017 09:46:53 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170103094653.GC5715@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <CACyXjPxZePbjS-zm1CeCLpzEuYkXSmVZ6w8vJpw8zO2iRyoZoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACyXjPxZePbjS-zm1CeCLpzEuYkXSmVZ6w8vJpw8zO2iRyoZoA@mail.gmail.com>
Subject: Re: [Qemu-devel] Did anything ever come of the Wireshark dissector
 generator that was being worked on
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Sharpe <realrichardsharpe@gmail.com>
Cc: qemu-devel@nongnu.org

On Thu, Dec 29, 2016 at 10:51:55AM -0800, Richard Sharpe wrote:
> Hi folks,
> 
> I saw on this page
> http://wiki.qemu.org/Features/LibvirtWiresharkDissector that someone
> was planning on writing a dissector generator for XDR.

It is complete and included in libvirt git for a couple of years now.

> I wish I had known about it when I started the following effort, which
> is now at a Version 1 level:
> 
> https://gitlab.com/realrichardsharpe/wireshark_rpcgen
> 
> As far as I am aware it handles all of XDR and is able to handle
> protocols that are specified across multiple XDR files (as that is
> what I needed.)
> 
> However, I would be interested in following up with the athor of the
> libvirt version.

The original author was a google summer of code student and no longer
active in the libvirt community. It is now maintained collaboratatively
by the libvirt developers.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
