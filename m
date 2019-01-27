Received: from eggs.gnu.org ([209.51.188.92]:40030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnppr-0003sk-IN
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 14:11:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnppq-0004DV-Jf
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 14:11:15 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529]:33745)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gnppq-0004D2-8d
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 14:11:14 -0500
Received: by mail-pg1-x529.google.com with SMTP id z11so6296908pgu.0
	for <qemu-devel@nongnu.org>; Sun, 27 Jan 2019 11:11:13 -0800 (PST)
References: <20190127114659.12881-1-samuel.thibault@ens-lyon.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <60153071-3be0-584f-94b1-bb199a81e7fc@linaro.org>
Date: Sun, 27 Jan 2019 11:11:09 -0800
MIME-Version: 1.0
In-Reply-To: <20190127114659.12881-1-samuel.thibault@ens-lyon.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] slirp: replace QEMU_BUILD_BUG_ON with
 G_STATIC_ASSERT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-devel@nongnu.org
Cc: lizhijian@cn.fujitsu.com, jan.kiszka@siemens.com, jasowang@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, zhangckid@gmail.com

On 1/27/19 3:46 AM, Samuel Thibault wrote:
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> ---
>  slirp/ip.h       |  4 ++--
>  slirp/ip6.h      |  4 ++--
>  slirp/ip6_icmp.h | 10 +++++-----
>  3 files changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
