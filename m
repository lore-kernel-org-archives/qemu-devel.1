Received: from eggs.gnu.org ([2001:4830:134:3::10]:43158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDcv-0000KB-4a
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:18:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDcr-00007n-Ne
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:18:41 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:33804)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEDcr-00006S-9X
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:18:37 -0400
Received: by mail-wm1-x335.google.com with SMTP id z25-v6so7245672wmf.1
	for <qemu-devel@nongnu.org>; Sun, 21 Oct 2018 06:18:37 -0700 (PDT)
References: <20181019010625.25294-1-cota@braap.org>
	<20181019010625.25294-28-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <726d27a5-da59-6b38-496f-08c438c4e970@linaro.org>
Date: Sun, 21 Oct 2018 14:18:33 +0100
MIME-Version: 1.0
In-Reply-To: <20181019010625.25294-28-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 27/56] s390x: use cpu_reset_interrupt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 10/19/18 2:05 AM, Emilio G. Cota wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: qemu-s390x@nongnu.org
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/s390x/excp_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
