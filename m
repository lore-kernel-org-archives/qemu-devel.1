Received: from eggs.gnu.org ([2001:4830:134:3::10]:40519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dX4jP-00065D-AV
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:02:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dX4jO-0005jp-A2
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:02:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dX4jO-0005hW-44
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:02:30 -0400
Date: Mon, 17 Jul 2017 14:01:41 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170717140116.32a24e6f@gondolin>
In-Reply-To: <20170717081152.17153-10-lprosek@redhat.com>
References: <20170717081152.17153-1-lprosek@redhat.com>
	<20170717081152.17153-10-lprosek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 9/9] checkpatch: add virtio_error and
 virtqueue_error to error funcs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ladi Prosek <lprosek@redhat.com>
Cc: qemu-devel@nongnu.org, casasfernando@hotmail.com, mst@redhat.com, jasowang@redhat.com, armbru@redhat.com, groug@kaod.org, arei.gonglei@huawei.com, aneesh.kumar@linux.vnet.ibm.com

On Mon, 17 Jul 2017 10:11:52 +0200
Ladi Prosek <lprosek@redhat.com> wrote:

> Two more error functions that should not contain newlines.
> 
> Suggested-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: Ladi Prosek <lprosek@redhat.com>
> ---
>  scripts/checkpatch.pl | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
