Received: from eggs.gnu.org ([209.51.188.92]:36577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gtr9S-0007fc-Kw
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 04:48:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gtr9R-0007TQ-Tq
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 04:48:22 -0500
Date: Wed, 13 Feb 2019 10:48:13 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190213104813.7c79c44a.cohuck@redhat.com>
In-Reply-To: <20190212011657.18324-3-walling@linux.ibm.com>
References: <20190212011657.18324-1-walling@linux.ibm.com>
	<20190212011657.18324-3-walling@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/3] s390x/cpumodel: add z14 GA2 model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Collin Walling <walling@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, david@redhat.com, borntraeger@de.ibm.com, pasic@linux.ibm.com, rth@twiddle.net

On Mon, 11 Feb 2019 20:16:57 -0500
Collin Walling <walling@linux.ibm.com> wrote:

> Introduce the z14 GA2 cpu model for QEMU. There are no new features
> introduced with this model, and will inherit the same feature set as
> z14 GA1.
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu_models.c   | 1 +
>  target/s390x/gen-features.c | 7 +++++++
>  2 files changed, 8 insertions(+)

Thanks, applied.
