Received: from eggs.gnu.org ([2001:4830:134:3::10]:60156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eYZFO-0005em-Np
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:21:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eYZFO-0000VA-0H
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:21:58 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20171221142251.18366-8-kwolf@redhat.com>
References: <20171221142251.18366-1-kwolf@redhat.com>
	<20171221142251.18366-8-kwolf@redhat.com>
Date: Mon, 08 Jan 2018 16:21:49 +0100
Message-ID: <w51o9m48jg2.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 07/19] test-bdrv-drain:
 Test drain vs. block jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

On Thu 21 Dec 2017 03:22:39 PM CET, Kevin Wolf wrote:
> Block jobs must be paused if any of the involved nodes are drained.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
