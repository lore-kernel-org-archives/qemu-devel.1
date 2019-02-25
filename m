Received: from eggs.gnu.org ([209.51.188.92]:44923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gyIUA-0005NA-U3
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:48:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gyIU6-0004U6-32
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:48:06 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534]:36928)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gyIU1-000486-59
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:47:58 -0500
Received: by mail-pg1-x534.google.com with SMTP id q206so4670086pgq.4
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 07:47:47 -0800 (PST)
References: <20190225115552.7534-1-david@redhat.com>
	<20190225115552.7534-4-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fcc3c308-9a58-d5db-db4e-6ab3d61585d8@linaro.org>
Date: Mon, 25 Feb 2019 07:47:43 -0800
MIME-Version: 1.0
In-Reply-To: <20190225115552.7534-4-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 3/7] s390x/tcg: Clarify terminology in
 vec_reg_offset()
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
> We will use s390x speak "Element Size" (es) for MO_8 == 0, MO_16 == 1
> ... Simple rename of variables.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/translate.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
