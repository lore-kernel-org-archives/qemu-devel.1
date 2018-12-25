Received: from eggs.gnu.org ([208.118.235.92]:39275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbszT-0003pX-Lc
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:07:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbszQ-000165-Jv
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:07:47 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:41375)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gbszQ-00015A-4u
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:07:44 -0500
Received: by mail-pg1-x543.google.com with SMTP id m1so6788149pgq.8
	for <qemu-devel@nongnu.org>; Tue, 25 Dec 2018 12:07:44 -0800 (PST)
References: <20181223113859.3675-1-mark.cave-ayland@ilande.co.uk>
	<20181223113859.3675-2-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bb65fde2-66e5-a312-37c3-1a109205832f@linaro.org>
Date: Wed, 26 Dec 2018 07:07:34 +1100
MIME-Version: 1.0
In-Reply-To: <20181223113859.3675-2-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/6] target/ppc: implement complete set of
 Vsr* macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 12/23/18 10:38 PM, Mark Cave-Ayland wrote:
> This prepares us for eliminating the use of direct array access within the VMX
> instruction implementations.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/internal.h | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
