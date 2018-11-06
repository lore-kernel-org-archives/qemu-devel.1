Received: from eggs.gnu.org ([2001:4830:134:3::10]:42409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gK4zy-000861-Fg
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 12:18:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gK4zu-00026N-GQ
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 12:18:39 -0500
Date: Tue, 6 Nov 2018 18:17:45 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181106171745.GF4758@linux.fritz.box>
References: <20180919124343.28206-1-vsementsov@virtuozzo.com>
	<9da2e343-e8fc-1cba-5c0a-65da5bff80dd@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9da2e343-e8fc-1cba-5c0a-65da5bff80dd@virtuozzo.com>
Subject: Re: [Qemu-devel] ping2 Re: [PATCH 0/2] replication: drop extra sync
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "xiechanglong.d@gmail.com" <xiechanglong.d@gmail.com>, "wencongyang2@huawei.com" <wencongyang2@huawei.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "jcody@redhat.com" <jcody@redhat.com>, Denis Lunev <den@virtuozzo.com>, "famz@redhat.com" <famz@redhat.com>

Am 31.10.2018 um 10:30 hat Vladimir Sementsov-Ogievskiy geschrieben:
> ping2
> 
> Hi, it's a first step to backup refactoring and improving. Just get rid 
> of this extra and unnatural synchronization.

The replication maintainers don't seem to have an opinion about this, so
thanks, applied to block-next (for 3.2).

Kevin
