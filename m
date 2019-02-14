Received: from eggs.gnu.org ([209.51.188.92]:49623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1guEWk-0001c2-Ue
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 05:45:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1guEWi-0000zQ-2o
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 05:45:58 -0500
Date: Thu, 14 Feb 2019 11:45:32 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190214114532.67b2c067.cohuck@redhat.com>
In-Reply-To: <20190212153025.25425-1-cohuck@redhat.com>
References: <20190212153025.25425-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390x/kvm: add tracepoint to ioeventfd
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On Tue, 12 Feb 2019 16:30:25 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> Trace when assigning/unassigning.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  target/s390x/kvm.c        | 2 ++
>  target/s390x/trace-events | 1 +
>  2 files changed, 3 insertions(+)

Queued to s390-next (without the 's390' infix).
