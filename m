Received: from eggs.gnu.org ([209.51.188.92]:55322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMRB4-0007aT-QR
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:56:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMRB2-0004Xr-AB
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:56:10 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:36079)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMRB1-0004Wb-Iy
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:56:07 -0400
Received: by mail-pf1-x442.google.com with SMTP id v80so2355799pfa.3
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 22:56:07 -0700 (PDT)
References: <20190502141019.6385-1-david@redhat.com>
	<20190502141019.6385-31-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2d2fd239-092c-1ad3-4ff3-eca138ca3ba8@linaro.org>
Date: Thu, 2 May 2019 22:56:02 -0700
MIME-Version: 1.0
In-Reply-To: <20190502141019.6385-31-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 30/40] s390x/tcg: Implement VECTOR SHIFT
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

On 5/2/19 7:10 AM, David Hildenbrand wrote:
> Inline expansion courtesy of Richard H.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c | 29 +++++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
