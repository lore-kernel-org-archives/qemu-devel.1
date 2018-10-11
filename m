Received: from eggs.gnu.org ([2001:4830:134:3::10]:34772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAj0O-00054v-RW
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 18:00:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAj0L-0007da-MW
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 18:00:28 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:37451)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gAj0L-0007bW-9l
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 18:00:25 -0400
Received: by mail-pg1-x542.google.com with SMTP id c10-v6so4811325pgq.4
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 15:00:25 -0700 (PDT)
References: <20181010144853.13005-1-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c9b7b557-a3c9-0e7b-995f-d407c4291450@linaro.org>
Date: Thu, 11 Oct 2018 15:00:20 -0700
MIME-Version: 1.0
In-Reply-To: <20181010144853.13005-1-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/4] some TCG fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 10/10/18 7:48 AM, Emilio G. Cota wrote:
> The first patch we've seen before -- I'm taking it from the
> atomic interrupt_request series.
> 
> The other three patches are related to TCG profiling. One
> of them is a build fix that I suspect has gone unnoticed
> due to its dependence on CONFIG_PROFILER.
> 
> The series is checkpatch-clean. You can fetch it from:
>   https://github.com/cota/qemu/tree/tcg-profile

Queued, thanks.


r~
