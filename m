Received: from eggs.gnu.org ([2001:4830:134:3::10]:40479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clXhP-0002QA-1e
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 04:15:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clXhO-0002Fr-2w
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 04:15:58 -0500
Date: Wed, 8 Mar 2017 10:15:46 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170308091546.GC5211@noname.redhat.com>
References: <20170228193340.63980-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170228193340.63980-1-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v4] backup: allow target without
 .bdrv_get_info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, jcody@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com

Am 28.02.2017 um 20:33 hat Vladimir Sementsov-Ogievskiy geschrieben:
> Currently backup to nbd target is broken, as nbd doesn't have
> .bdrv_get_info realization.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Thanks, applied to the block branch.

Kevin
