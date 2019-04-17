Received: from eggs.gnu.org ([209.51.188.92]:45494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGcc6-0001Xy-JX
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 00:56:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGcc5-000216-MU
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 00:56:02 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:34422)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hGcc5-0001zm-BN
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 00:56:01 -0400
Received: by mail-pg1-x541.google.com with SMTP id v12so11427123pgq.1
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 21:56:01 -0700 (PDT)
References: <20190416185301.25344-1-david@redhat.com>
	<20190416185301.25344-38-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <86abb048-1981-a72e-7741-948307c78396@linaro.org>
Date: Tue, 16 Apr 2019 18:55:56 -1000
MIME-Version: 1.0
In-Reply-To: <20190416185301.25344-38-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 37/41] s390x/tcg: Implement VECTOR
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

On 4/16/19 8:52 AM, David Hildenbrand wrote:
> Mostly courtesy of Richard H.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c | 34 +++++++++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
