Received: from eggs.gnu.org ([2001:4830:134:3::10]:49757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1etxL6-0001Ld-PJ
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 10:20:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1etxL3-0002E8-JC
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 10:20:16 -0500
Date: Thu, 8 Mar 2018 16:20:01 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180308162001.4b4b75ca.cohuck@redhat.com>
In-Reply-To: <20180307162958.11232-1-nia.alarie@gmail.com>
References: <20180307162958.11232-1-nia.alarie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390x/virtio: Convert virtio-ccw from
 *_exit to *_unrealize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nia Alarie <nia.alarie@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, borntraeger@de.ibm.com, stefanha@gmail.com, jim@groklearning.com, joel@jms.id.au

On Wed,  7 Mar 2018 16:29:58 +0000
Nia Alarie <nia.alarie@gmail.com> wrote:

> Signed-off-by: Nia Alarie <nia.alarie@gmail.com>
> ---
>  hw/s390x/virtio-ccw.c | 34 +++++++++++++++++-----------------
>  hw/s390x/virtio-ccw.h |  2 +-
>  2 files changed, 18 insertions(+), 18 deletions(-)

Thanks, applied.
