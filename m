Received: from eggs.gnu.org ([2001:4830:134:3::10]:55962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gP2mU-0004hR-6E
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 04:57:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gP2mR-0003n5-31
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 04:57:18 -0500
Date: Tue, 20 Nov 2018 10:57:07 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181120105707.2778660d.cohuck@redhat.com>
In-Reply-To: <20181119110548.812-1-cohuck@redhat.com>
References: <20181119110548.812-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.0] s390x: introduce 4.0 compat machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org

On Mon, 19 Nov 2018 12:05:48 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  hw/s390x/s390-virtio-ccw.c | 17 ++++++++++++++++-
>  include/hw/compat.h        |  3 +++
>  2 files changed, 19 insertions(+), 1 deletion(-)

Queued to s390-next.
