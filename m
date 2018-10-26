Received: from eggs.gnu.org ([2001:4830:134:3::10]:49998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG4IT-00041t-Iv
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:45:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG4IQ-00021j-Cz
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:45:13 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534]:42583)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gG4IO-0001qh-1e
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:45:08 -0400
Received: by mail-pg1-x534.google.com with SMTP id i4-v6so713401pgq.9
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 08:45:08 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-42-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <551e66ac-cfb8-0d27-e290-75070d8b1eb9@linaro.org>
Date: Fri, 26 Oct 2018 16:45:00 +0100
MIME-Version: 1.0
In-Reply-To: <20181025144644.15464-42-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 42/71] ppc: convert to
 cpu_interrupt_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org

On 10/25/18 3:46 PM, Emilio G. Cota wrote:
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: qemu-ppc@nongnu.org
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  hw/ppc/ppc.c                    |  2 +-
>  target/ppc/excp_helper.c        |  2 +-
>  target/ppc/kvm.c                |  4 ++--
>  target/ppc/translate_init.inc.c | 14 +++++++-------
>  4 files changed, 11 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
