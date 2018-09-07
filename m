Received: from eggs.gnu.org ([2001:4830:134:3::10]:54407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fyG1d-00030s-U4
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 08:38:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fyG1a-0005wB-7X
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 08:38:13 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180809223117.7846-2-mreitz@redhat.com>
References: <20180809223117.7846-1-mreitz@redhat.com>
	<20180809223117.7846-2-mreitz@redhat.com>
Date: Fri, 07 Sep 2018 14:37:53 +0200
Message-ID: <w51k1nxiiu6.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 01/11] block: Mark commit
 and mirror as filter drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

On Fri 10 Aug 2018 12:31:07 AM CEST, Max Reitz wrote:
> The commit and mirror block nodes are filters, so they should be marked
> as such.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
