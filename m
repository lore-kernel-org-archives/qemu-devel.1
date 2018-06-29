Received: from eggs.gnu.org ([2001:4830:134:3::10]:53204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYxnK-0001fI-GL
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 14:06:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYxnJ-0003qH-OL
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 14:06:54 -0400
Date: Fri, 29 Jun 2018 20:06:45 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180629180645.GL15588@localhost.localdomain>
References: <20180620144837.19341-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620144837.19341-1-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] qcow2 compress threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@gmail.com, pl@kamp.de, den@openvz.org

Am 20.06.2018 um 16:48 hat Vladimir Sementsov-Ogievskiy geschrieben:
> Hi all!
> 
> Here are compress threads for qcow2, to increase performance of
> compressed writes.

Thanks, applied to the block branch.

Kevin
