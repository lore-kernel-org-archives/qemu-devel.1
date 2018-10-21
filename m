Received: from eggs.gnu.org ([2001:4830:134:3::10]:42265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDa0-0005pT-IK
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:15:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDZx-0006QF-CV
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:15:40 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:37069)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEDZx-0006Mi-0F
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:15:37 -0400
Received: by mail-wm1-x334.google.com with SMTP id 185-v6so7724365wmt.2
	for <qemu-devel@nongnu.org>; Sun, 21 Oct 2018 06:15:29 -0700 (PDT)
References: <20181019010625.25294-1-cota@braap.org>
	<20181019010625.25294-25-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6d49734a-b3b9-b58a-2562-69a46241900b@linaro.org>
Date: Sun, 21 Oct 2018 14:15:23 +0100
MIME-Version: 1.0
In-Reply-To: <20181019010625.25294-25-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC v3 24/56] ppc: use cpu_reset_interrupt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>

On 10/19/18 2:05 AM, Emilio G. Cota wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: qemu-ppc@nongnu.org
> Acked-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/ppc/excp_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
