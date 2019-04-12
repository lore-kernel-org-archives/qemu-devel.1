Received: from eggs.gnu.org ([209.51.188.92]:36355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hEv7B-00031I-Uv
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:17:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hEv7A-0004jV-T9
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:17:05 -0400
Date: Fri, 12 Apr 2019 14:16:57 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190412121657.GF4522@linux.fritz.box>
References: <20190410204215.5963-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410204215.5963-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-4.0?] iotest: Fix 241 to run in generic
 directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, qemu-block@nongnu.org, mreitz@redhat.com, John Snow <jsnow@redhat.com>

Am 10.04.2019 um 22:42 hat Eric Blake geschrieben:
> Filter the qemu-nbd server output to get rid of a direct reference
> to my build directory.
> 
> Fixes: e9dce9cb
> Reported-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Thanks, applied to the block branch.

Kevin
