Received: from eggs.gnu.org ([2001:4830:134:3::10]:51110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eZxyS-0006A8-PR
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:58:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eZxyP-0002o4-KI
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:58:16 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <cover.1513342045.git.berto@igalia.com>
References: <cover.1513342045.git.berto@igalia.com>
Date: Fri, 12 Jan 2018 12:58:10 +0100
Message-ID: <w51efmvuw4t.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 00/32] Allow configuring the qcow2 L2
 cache entry size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>

ping

On Fri 15 Dec 2017 01:53:28 PM CET, Alberto Garcia wrote:
> Hello all,
>
> this is the new revision of the patch series to allow configuring the
> entry size of the qcow2 L2 cache. Follow this link for the full
> description from the first version:
>
>    https://lists.gnu.org/archive/html/qemu-block/2017-10/msg00458.html
