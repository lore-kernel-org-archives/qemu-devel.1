Received: from eggs.gnu.org ([209.51.188.92]:45617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gvpwy-00058H-SI
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 15:55:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gvpwu-00049d-V9
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 15:55:38 -0500
References: <20190218161822.3573-1-kwolf@redhat.com>
	<20190218161822.3573-11-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <469434e4-9ec9-9453-5612-b9d4298cb497@redhat.com>
Date: Mon, 18 Feb 2019 14:55:11 -0600
MIME-Version: 1.0
In-Reply-To: <20190218161822.3573-11-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 10/12] test-bdrv-drain: AioContext switch
 in drained section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, stefanha@redhat.com, berrange@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org

On 2/18/19 10:18 AM, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/test-bdrv-drain.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
