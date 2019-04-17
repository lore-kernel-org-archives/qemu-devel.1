Received: from eggs.gnu.org ([209.51.188.92]:44980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGcZg-0000R9-6x
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 00:53:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGcZe-0000ec-TQ
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 00:53:32 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:46014)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hGcZe-0000dq-II
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 00:53:30 -0400
Received: by mail-pg1-x542.google.com with SMTP id y3so11392357pgk.12
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 21:53:30 -0700 (PDT)
References: <20190416185301.25344-1-david@redhat.com>
	<20190416185301.25344-32-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b80951bd-114b-1afe-10ff-f994e3f1b26a@linaro.org>
Date: Tue, 16 Apr 2019 18:53:24 -1000
MIME-Version: 1.0
In-Reply-To: <20190416185301.25344-32-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 31/41] s390x/tcg: Implement VECTOR SHIFT
 LEFT DOUBLE BY BYTE
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

On 4/16/19 8:52 AM, David Hildenbrand wrote:
> Inline expansion courtesy of Richard H.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c | 29 +++++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
