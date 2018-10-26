Received: from eggs.gnu.org ([2001:4830:134:3::10]:52280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG4MD-0007ry-NZ
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:49:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG4MA-0006Xa-HQ
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:49:05 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c]:34201)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gG4MA-0006Wi-Aq
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:49:02 -0400
Received: by mail-pl1-x62c.google.com with SMTP id f10-v6so711313plr.1
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 08:49:02 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-58-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b4958e02-a03a-614b-8cd0-6ce0118e101a@linaro.org>
Date: Fri, 26 Oct 2018 16:48:56 +0100
MIME-Version: 1.0
In-Reply-To: <20181025144644.15464-58-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 58/71] cpu: call .cpu_has_work with the
 CPU lock held
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
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  include/qom/cpu.h | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
