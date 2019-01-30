Received: from eggs.gnu.org ([209.51.188.92]:57864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gonDg-00075F-UJ
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 05:35:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gonDf-0004eb-Tm
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 05:35:48 -0500
Date: Wed, 30 Jan 2019 11:35:37 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190130113537.384cd682.cohuck@redhat.com>
In-Reply-To: <20190130004811.27372-66-cota@braap.org>
References: <20190130004811.27372-1-cota@braap.org>
	<20190130004811.27372-66-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 65/73] s390x: convert to
 cpu_has_work_with_iothread_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org

On Tue, 29 Jan 2019 19:48:03 -0500
"Emilio G. Cota" <cota@braap.org> wrote:

> Soon we will call cpu_has_work without the BQL.
> 
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: qemu-s390x@nongnu.org
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/s390x/cpu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
