Received: from eggs.gnu.org ([2001:4830:134:3::10]:49111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fiKuU-0003YY-6b
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 10:37:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fiKuR-0007yy-81
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 10:37:02 -0400
Date: Wed, 25 Jul 2018 16:36:52 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180725163652.1e724523.cohuck@redhat.com>
In-Reply-To: <20180723131016.4161-1-cohuck@redhat.com>
References: <20180723131016.4161-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.1] s390x: introduce 3.1 compat machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

On Mon, 23 Jul 2018 15:10:16 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  hw/s390x/s390-virtio-ccw.c | 17 ++++++++++++++++-
>  include/hw/compat.h        |  3 +++
>  2 files changed, 19 insertions(+), 1 deletion(-)

Queued to s390-next.
