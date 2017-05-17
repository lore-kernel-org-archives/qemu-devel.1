Received: from eggs.gnu.org ([2001:4830:134:3::10]:42220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dAxDx-00021z-Qh
	for qemu-devel@nongnu.org; Wed, 17 May 2017 07:34:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dAxDx-0000gN-36
	for qemu-devel@nongnu.org; Wed, 17 May 2017 07:34:37 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170516204724.1617-8-eblake@redhat.com> (Eric Blake's message
	of "Tue, 16 May 2017 15:47:19 -0500")
References: <20170516204724.1617-1-eblake@redhat.com>
	<20170516204724.1617-8-eblake@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 17 May 2017 13:34:23 +0200
Message-ID: <87a86bd8e8.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 07/12] dirty-bitmap: Change
 bdrv_get_dirty_count() to report bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Eric Blake <eblake@redhat.com> wrote:
> Thanks to recent cleanups, all callers were scaling a return value
> of sectors into bytes; do the scaling internally instead.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
>

Reviewed-by: Juan Quintela <quintela@redhat.com>
