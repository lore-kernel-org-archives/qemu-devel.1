Received: from eggs.gnu.org ([209.51.188.92]:48474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMcsY-0006b8-Mu
	for qemu-devel@nongnu.org; Fri, 03 May 2019 14:25:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMcsX-000662-Sw
	for qemu-devel@nongnu.org; Fri, 03 May 2019 14:25:50 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633]:40702)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMcsX-00064z-LL
	for qemu-devel@nongnu.org; Fri, 03 May 2019 14:25:49 -0400
Received: by mail-pl1-x633.google.com with SMTP id b3so3063990plr.7
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 11:25:49 -0700 (PDT)
References: <20190502141019.6385-1-david@redhat.com>
	<20190502141019.6385-37-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e513e687-0f14-9afc-a717-99c2e969248d@linaro.org>
Date: Fri, 3 May 2019 11:25:45 -0700
MIME-Version: 1.0
In-Reply-To: <20190502141019.6385-37-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 36/40] s390x/tcg: Implement VECTOR
 SUBTRACT WITH BORROW COMPUTE BORROW INDICATION
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>

On 5/2/19 7:10 AM, David Hildenbrand wrote:
> Mostly courtesy of Richard H.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c | 34 +++++++++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
