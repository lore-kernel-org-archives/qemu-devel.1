Received: from eggs.gnu.org ([2001:4830:134:3::10]:37630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gKKYO-0004fm-Vs
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 04:55:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gKKYN-00036F-TM
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 04:55:16 -0500
Date: Wed, 7 Nov 2018 10:54:52 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181107095452.GA4721@linux.fritz.box>
References: <1540794581-33578-1-git-send-email-liq3ea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540794581-33578-1-git-send-email-liq3ea@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] nvme: fix two issues in nvme unhotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: keith.busch@intel.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org

Am 29.10.2018 um 07:29 hat Li Qiang geschrieben:
> The first corrent the refcount and second fix a memory leak.

Thanks, applied to the block branch.

Kevin
