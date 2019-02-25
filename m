Received: from eggs.gnu.org ([209.51.188.92]:44687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gyIT9-0004dP-Po
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:47:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gyIT9-0003H9-1i
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:47:03 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:43990)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gyIT8-00037j-MX
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:47:02 -0500
Received: by mail-pg1-x543.google.com with SMTP id l11so4651552pgq.10
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 07:46:53 -0800 (PST)
References: <20190225115552.7534-1-david@redhat.com>
	<20190225115552.7534-2-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8f705be2-d90f-e99a-55d3-34879a283072@linaro.org>
Date: Mon, 25 Feb 2019 07:46:49 -0800
MIME-Version: 1.0
In-Reply-To: <20190225115552.7534-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 1/7] s390x/tcg: RXE has an optional M3
 field
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

On 2/25/19 3:55 AM, David Hildenbrand wrote:
> Will be needed, so add it to the format description.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-format.def | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
