Received: from eggs.gnu.org ([2001:4830:134:3::10]:38173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f3Me6-0001KZ-I5
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 10:10:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f3Me1-0000Zf-K6
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 10:10:46 -0400
Date: Tue, 3 Apr 2018 16:10:33 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180403161033.74ed9838.cohuck@redhat.com>
In-Reply-To: <20180329113320.8053-1-cohuck@redhat.com>
References: <20180329113320.8053-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.13] s390x: introduce 2.13 compat
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org

On Thu, 29 Mar 2018 13:33:20 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
> Yes, it's that time again :)
> ---
>  hw/s390x/s390-virtio-ccw.c | 17 ++++++++++++++++-
>  include/hw/compat.h        |  3 +++
>  2 files changed, 19 insertions(+), 1 deletion(-)

Queued to s390-next (but will still take R-bs/A-bs).
