Received: from eggs.gnu.org ([2001:4830:134:3::10]:48427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eJGYm-0004hl-1Q
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 05:22:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eJGYi-0004gN-To
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 05:22:44 -0500
Date: Mon, 27 Nov 2017 11:22:33 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171127112233.412b6c4a.cohuck@redhat.com>
In-Reply-To: <20171124153344.22972-1-cohuck@redhat.com>
References: <20171124153344.22972-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12] s390x: introduce 2.12 compat
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, thuth@redhat.com, david@redhat.com

On Fri, 24 Nov 2017 16:33:44 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  hw/s390x/s390-virtio-ccw.c | 17 ++++++++++++++++-
>  include/hw/compat.h        |  3 +++
>  2 files changed, 19 insertions(+), 1 deletion(-)

Queued to s390-next.
