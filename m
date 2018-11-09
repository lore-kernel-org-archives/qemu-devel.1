Received: from eggs.gnu.org ([2001:4830:134:3::10]:38383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gL7Ac-0003kv-Ea
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 08:49:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gL7AX-0002y7-Im
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 08:49:57 -0500
Date: Fri, 9 Nov 2018 14:49:41 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181109144941.471b4028.cohuck@redhat.com>
In-Reply-To: <20181025144644.15464-50-cota@braap.org>
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-50-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 50/71] s390x: convert to
 cpu_interrupt_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org

On Thu, 25 Oct 2018 10:46:23 -0400
"Emilio G. Cota" <cota@braap.org> wrote:

> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: qemu-s390x@nongnu.org
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  hw/intc/s390_flic.c | 2 +-
>  target/s390x/cpu.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
