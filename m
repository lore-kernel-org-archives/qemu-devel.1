Received: from eggs.gnu.org ([2001:4830:134:3::10]:48360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fmzw0-0004uq-0K
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 07:13:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fmzvz-0006uH-9b
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 07:13:51 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180806123728.13658-1-kwolf@redhat.com>
References: <20180806123728.13658-1-kwolf@redhat.com>
Date: Tue, 07 Aug 2018 13:13:07 +0200
Message-ID: <w5136vqa0qk.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] qapi/block: Document
 restrictions for node names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: coli@redhat.com, qemu-devel@nongnu.org

On Mon 06 Aug 2018 02:37:28 PM CEST, Kevin Wolf wrote:
> blockdev-add fails if an invalid node name is given, so we should
> document what a valid node name even is.
>
> Reported-by: Cong Li <coli@redhat.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
