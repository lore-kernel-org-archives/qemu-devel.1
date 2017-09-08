Received: from eggs.gnu.org ([2001:4830:134:3::10]:35829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dqGpk-0005Hj-LP
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:48:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dqGpg-0007Au-7l
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:48:24 -0400
Date: Fri, 8 Sep 2017 12:47:58 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170908104758.GB3283@localhost.localdomain>
References: <20170908083941.14591-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170908083941.14591-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6] docs: add qemu-block-drivers(7) man page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, el13635@mail.ntua.gr

Am 08.09.2017 um 10:39 hat Stefan Hajnoczi geschrieben:
> Block driver documentation is available in qemu-doc.html.  It would be
> convenient to have documentation for formats, protocols, and filter
> drivers in a man page.
> 
> Extract the relevant part of qemu-doc.html into a new file called
> docs/qemu-block-drivers.texi.  This file can also be built as a
> stand-alone document (man, html, etc).
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Thanks, applied to the block branch.

Kevin
