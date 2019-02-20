Received: from eggs.gnu.org ([209.51.188.92]:33285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gwU9t-0005z5-6K
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:51:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gwU9s-0006WK-E9
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:51:41 -0500
Date: Wed, 20 Feb 2019 16:51:28 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190220165128.630ad793.cohuck@redhat.com>
In-Reply-To: <1550519397-25359-3-git-send-email-akrowiak@linux.ibm.com>
References: <1550519397-25359-1-git-send-email-akrowiak@linux.ibm.com>
	<1550519397-25359-3-git-send-email-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/2] s390x/vfio-ap: document hot
 plug/unplug of vfio-ap device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, borntraeger@de.ibm.com, david@redhat.com, pmorel@linux.ibm.com, alifm@linux.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, fiuczy@linux.ibm.com

On Mon, 18 Feb 2019 14:49:57 -0500
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> Let's update the vfio-ap.txt document to include the hot plug/unplug
> support introduced in this patch set.

s/ introduced in this patch set//

Nobody will know about this patch set when they look at the commit in
the future :)

> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>  docs/vfio-ap.txt | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 56 insertions(+), 5 deletions(-)

Looks good to me, but would not mind a R-b before queuing.
