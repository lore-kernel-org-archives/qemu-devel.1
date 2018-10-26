Received: from eggs.gnu.org ([2001:4830:134:3::10]:53319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG4On-0001nW-0c
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:51:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG4Oj-0007Sy-PN
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:51:44 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:38967)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gG4Oj-0007Pc-8j
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:51:41 -0400
Received: by mail-wm1-x32f.google.com with SMTP id y144-v6so1890056wmd.4
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 08:51:29 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-59-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e4fc6dd8-d309-f9f8-2952-71f5897644e0@linaro.org>
Date: Fri, 26 Oct 2018 16:51:25 +0100
MIME-Version: 1.0
In-Reply-To: <20181025144644.15464-59-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 59/71] cpu: introduce
 cpu_has_work_with_iothread_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

On 10/25/18 3:46 PM, Emilio G. Cota wrote:
> It will gain some users soon.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  include/qom/cpu.h | 36 +++++++++++++++++++++++++++++++++---
>  1 file changed, 33 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
