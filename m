Received: from eggs.gnu.org ([2001:4830:134:3::10]:57346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG4dJ-0003Qv-CZ
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 12:06:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG4dE-0000bH-Vg
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 12:06:45 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:52145)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gG4dE-0000X6-GA
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 12:06:40 -0400
Received: by mail-wm1-x336.google.com with SMTP id 143-v6so2008132wmf.1
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 09:06:26 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-70-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6837d44e-f611-a711-4c11-efa916319e42@linaro.org>
Date: Fri, 26 Oct 2018 17:06:23 +0100
MIME-Version: 1.0
In-Reply-To: <20181025144644.15464-70-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 70/71] cpus-common: move exclusive_idle
 higher in the file
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
> This will simplify the following commit's diff.
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  cpus-common.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
