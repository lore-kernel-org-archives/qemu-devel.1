Received: from eggs.gnu.org ([209.51.188.92]:50640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gxeuz-0000Rz-6S
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 16:33:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gxeuy-0008F7-J9
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 16:33:09 -0500
References: <20190223000614.13894-1-jsnow@redhat.com>
	<20190223000614.13894-9-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <95733cef-d2e3-e174-2e55-8ad8501d5a72@redhat.com>
Date: Sat, 23 Feb 2019 15:32:54 -0600
MIME-Version: 1.0
In-Reply-To: <20190223000614.13894-9-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 08/10] block/dirty-bitmaps: move comment
 block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com, Juan Quintela <quintela@redhat.com>, Max Reitz <mreitz@redhat.com>, libvir-list@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>

On 2/22/19 6:06 PM, John Snow wrote:
> Simply move the big status enum comment block to above the status
> function, and document it as being deprecated. The whole confusing
> block can get deleted in three releases time.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/dirty-bitmap.c | 36 +++++++++++++++++++-----------------
>  1 file changed, 19 insertions(+), 17 deletions(-)
> 
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
