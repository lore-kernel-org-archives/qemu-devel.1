Received: from eggs.gnu.org ([2001:4830:134:3::10]:51703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dSPkt-0003yJ-3v
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 11:28:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dSPks-0007RE-AW
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 11:28:47 -0400
Date: Tue, 4 Jul 2017 17:28:33 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170704152833.GL4253@noname.str.redhat.com>
References: <20170627192458.15519-1-eblake@redhat.com>
	<20170627192458.15519-4-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170627192458.15519-4-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 03/20] stream: Switch stream_populate()
 to byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, jsnow@redhat.com, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>

Am 27.06.2017 um 21:24 hat Eric Blake geschrieben:
> We are gradually converting to byte-based interfaces, as they are
> easier to reason about than sector-based.  Start by converting an
> internal function (no semantic change).
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
