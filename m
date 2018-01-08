Received: from eggs.gnu.org ([2001:4830:134:3::10]:42172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eYSZu-00063s-8q
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 03:14:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eYSZt-00007P-Gd
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 03:14:42 -0500
Date: Mon, 8 Jan 2018 16:14:33 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180108081433.GF5443@lemon.usersys.redhat.com>
References: <20180105225753.30509-1-eblake@redhat.com>
	<20180105225753.30509-19-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180105225753.30509-19-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 18/20] vpc: Switch to
 .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jcody@redhat.com, qemu-block@nongnu.org, vsementsov@virtuozzo.com, Max Reitz <mreitz@redhat.com>

On Fri, 01/05 16:57, Eric Blake wrote:
> We are gradually moving away from sector-based interfaces, towards
> byte-based.  Update the vpc driver accordingly.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Reviewed-by: Fam Zheng <famz@redhat.com>
