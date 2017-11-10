Received: from eggs.gnu.org ([2001:4830:134:3::10]:46177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eDHS2-0002LX-Iy
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 17:07:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eDHRz-0002xV-EG
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 17:07:02 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <e089c66e7c20289b046d782cea4373b765c5bc1d.1510339534.git.berto@igalia.com>
References: <cover.1510339534.git.berto@igalia.com>
	<e089c66e7c20289b046d782cea4373b765c5bc1d.1510339534.git.berto@igalia.com>
Date: Fri, 10 Nov 2017 23:06:54 +0100
Message-ID: <w51fu9lpz41.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/3] block: Leave valid throttle timers
 when removing a BDS from a backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, sochin jiang <sochin.jiang@huawei.com>

On Fri 10 Nov 2017 07:54:47 PM CET, Alberto Garcia <berto@igalia.com> wrote:

I just noticed a typo in the commit message:

> There'a a couple of problems with this:

"There's a couple"

If there's no v2 of this series you can correct this when committing.

Berto
