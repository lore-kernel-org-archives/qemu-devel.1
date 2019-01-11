Received: from eggs.gnu.org ([209.51.188.92]:40379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ghteH-0003tJ-3L
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 05:02:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ghteG-0004JQ-9V
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 05:02:45 -0500
Date: Fri, 11 Jan 2019 11:02:22 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190111100222.GA5010@dhcp-200-186.str.redhat.com>
References: <20190110191901.5082-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110191901.5082-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/6] include: Auto-generate the sizes
 lookup table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, lbloch@janustech.com, armbru@redhat.com, qemu-block@nongnu.org

Am 10.01.2019 um 20:18 hat Eric Blake geschrieben:
> Patches speak louder than words.  This is my counter-proposal to
> Leonid's thread on how best to respresent the S_*iB macros in units.h,
> where my proposal is that we don't need them at all. (hence my subject
> line, even though it is completely unrelated to the series)
> 
> True, my diffstat is even bigger, but I think it is more maintainable
> in the long run (if calling QemuOpts maintainable is even appropriate).

We're wasting too much time on this stuff. But anyway, I consider this
part of Markus' maintainership area, and if he likes to merge it, I
don't mind. I did not actually review this in detail.

Acked-by: Kevin Wolf <kwolf@redhat.com>
