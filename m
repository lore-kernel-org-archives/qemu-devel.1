Received: from eggs.gnu.org ([2001:4830:134:3::10]:40349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAjMG-000081-JO
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 18:23:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAjMD-0004XK-DG
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 18:23:04 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:38540)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gAjMC-0004Vy-W2
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 18:23:01 -0400
Received: by mail-pf1-x441.google.com with SMTP id f29-v6so5111920pff.5
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 15:22:59 -0700 (PDT)
References: <20181009174557.16125-1-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3e9d004c-994a-0a54-6eef-82042dc9c94b@linaro.org>
Date: Thu, 11 Oct 2018 15:22:54 -0700
MIME-Version: 1.0
In-Reply-To: <20181009174557.16125-1-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 0/6] per-TLB lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 10/9/18 10:45 AM, Emilio G. Cota wrote:
> v4: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg01421.html
> 
> Changes since v4:
> 
> - Add two patches to remove early calls to tlb_flush.
> 
> You can fetch the series from:
>   https://github.com/cota/qemu/tree/tlb-lock-v5

Queued, thanks.


r~
