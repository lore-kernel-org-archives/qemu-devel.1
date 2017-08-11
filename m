Received: from eggs.gnu.org ([2001:4830:134:3::10]:36050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dgAwA-0004vJ-Pm
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:29:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dgAw6-0004zA-Mp
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:29:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dgAw6-0004z0-GR
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:29:14 -0400
Date: Fri, 11 Aug 2017 16:29:04 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170811162904.5d24c57b.cohuck@redhat.com>
In-Reply-To: <20170810123741.30449-1-cohuck@redhat.com>
References: <20170810123741.30449-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.11] s390x: introduce 2.11 compat
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, thuth@redhat.com, david@redhat.com

On Thu, 10 Aug 2017 14:37:41 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
> 
> It's that time again. I plan to put this into my first 2.11 pullreq.
> Yes, and I assume that the next version is indeed 2.11 :)
> 
> ---
>  hw/s390x/s390-virtio-ccw.c | 17 ++++++++++++++++-
>  include/hw/compat.h        |  3 +++
>  2 files changed, 19 insertions(+), 1 deletion(-)

Applied to s390-next.
