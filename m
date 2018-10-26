Received: from eggs.gnu.org ([2001:4830:134:3::10]:36172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG3YY-00051o-QP
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:57:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG3YV-00056p-LI
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:57:46 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:44003)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gG3YV-000561-Ca
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:57:43 -0400
Received: by mail-wr1-x42a.google.com with SMTP id t10-v6so1659342wrn.10
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 07:57:43 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-8-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <eb832043-f938-98dc-6989-40d33bd682e5@linaro.org>
Date: Fri, 26 Oct 2018 15:57:39 +0100
MIME-Version: 1.0
In-Reply-To: <20181025144644.15464-8-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 08/71] ppc: convert to
 helper_cpu_halted_set
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

On 10/25/18 3:45 PM, Emilio G. Cota wrote:
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: qemu-ppc@nongnu.org
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/ppc/translate.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
