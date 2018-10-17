Received: from eggs.gnu.org ([2001:4830:134:3::10]:34536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gChis-0005JP-7f
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:02:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gChim-0001L5-93
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:02:34 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20181012115532.12645-2-kwolf@redhat.com>
References: <20181012115532.12645-1-kwolf@redhat.com>
	<20181012115532.12645-2-kwolf@redhat.com>
Date: Wed, 17 Oct 2018 11:02:14 +0200
Message-ID: <w51efcpndyh.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 1/8] block: Update flags in
 bdrv_set_read_only()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com

On Fri 12 Oct 2018 01:55:25 PM CEST, Kevin Wolf wrote:
> To fully change the read-only state of a node, we must not only change
> bs->read_only, but also update bs->open_flags.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
