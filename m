Received: from eggs.gnu.org ([2001:4830:134:3::10]:42264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDa0-0005pS-IH
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:15:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDZx-0006QH-Cq
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:15:40 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:32865)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEDZw-0006G7-Lf
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:15:37 -0400
Received: by mail-wm1-x32e.google.com with SMTP id y140-v6so7238591wmd.0
	for <qemu-devel@nongnu.org>; Sun, 21 Oct 2018 06:15:18 -0700 (PDT)
References: <20181019010625.25294-1-cota@braap.org>
	<20181019010625.25294-24-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e779ef4a-e193-bc48-254e-1c18a9d9b9ac@linaro.org>
Date: Sun, 21 Oct 2018 14:15:05 +0100
MIME-Version: 1.0
In-Reply-To: <20181019010625.25294-24-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 23/56] cpu: define cpu_interrupt_request
 helpers
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

On 10/19/18 2:05 AM, Emilio G. Cota wrote:
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  include/qom/cpu.h | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
