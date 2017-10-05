Received: from eggs.gnu.org ([2001:4830:134:3::10]:45557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e03HI-00047j-2t
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 06:21:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e03HC-0006Sa-A6
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 06:21:16 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20171004152553.30263-3-mreitz@redhat.com>
References: <20171004152553.30263-1-mreitz@redhat.com>
	<20171004152553.30263-3-mreitz@redhat.com>
Date: Thu, 05 Oct 2017 12:21:03 +0200
Message-ID: <w51y3op520g.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v6 2/6] qapi/qlist: Add
 qlist_append_null() macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

On Wed 04 Oct 2017 05:25:49 PM CEST, Max Reitz wrote:
> Besides the macro itself, this patch also adds a corresponding
> Coccinelle rule.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
