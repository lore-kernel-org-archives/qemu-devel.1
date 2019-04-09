Received: from eggs.gnu.org ([209.51.188.92]:51258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hDmbD-0000qr-7N
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 04:59:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hDmbC-0006PM-5P
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 04:59:23 -0400
Date: Tue, 9 Apr 2019 09:59:14 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190409085913.GB2964@work-vm>
References: <CGME20190408123341eucas1p2add7886160b2b66912413defd4544d1f@eucas1p2.samsung.com>
	<c138abfe-61fd-6e04-8900-2ba2a24073de@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c138abfe-61fd-6e04-8900-2ba2a24073de@samsung.com>
Subject: Re: [Qemu-devel] [PATCH 00/97] Patch Round-up for stable 3.0.1,
 freeze on 2019-04-08
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ilya Maximets <i.maximets@samsung.com>
Cc: mdroth@linux.vnet.ibm.com, qemu-devel <qemu-devel@nongnu.org>, qemu-stable@nongnu.org

* Ilya Maximets (i.maximets@samsung.com) wrote:
> > Hi everyone,                                                                    
> >                           
> > 
> > The following new patches are queued for QEMU stable v3.0.1:
> > 
> >   https://github.com/mdroth/qemu/commits/stable-3.0-staging
> > 
> > The release is planned for 2019-04-11:
> > 
> >   https://wiki.qemu.org/Planning/3.0
> > 
> > Please respond here or CC address@hidden on any patches you
> > think should be included in the release.
> > 
> > Note that this update falls outside the normal stable release support
> > window (~1 development cycle), but is being release now since it was
> > delayed from its intended release date.
> > 
> > Thanks!
> > 
> 
> [...]
> 
> > 
> > Ilya Maximets (1):
> >       migration: Stop postcopy fault thread before notifying
> 
> Hi.
> 
> Sorry for late response, but what about following two patches:
> 
>   c4f753859ae6 ("vhost-user: Fix userfaultfd leak")
>   5ce43896e167 ("vhost-user: Don't ask for reply on postcopy mem table set")
> 
> ?

OK with me.

Dave

> Best regards, Ilya Maximets.
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
