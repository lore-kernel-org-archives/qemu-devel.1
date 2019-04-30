Received: from eggs.gnu.org ([209.51.188.92]:39137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLW24-00048d-1W
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:55:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLW0o-0001Tf-1J
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:53:46 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534]:37634)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLW0n-0001TT-Qi
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:53:45 -0400
Received: by mail-pg1-x534.google.com with SMTP id e6so7115726pgc.4
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 09:53:45 -0700 (PDT)
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
	<20190428143845.11810-13-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1f693689-a908-1499-8bfe-6f06c2afac44@linaro.org>
Date: Tue, 30 Apr 2019 09:53:33 -0700
MIME-Version: 1.0
In-Reply-To: <20190428143845.11810-13-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 12/14] target/ppc: decode target register
 in VSX_EXTRACT_INSERT at translation time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net, gkurz@kaod.org

On 4/28/19 7:38 AM, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/helper.h                 |  4 ++--
>  target/ppc/int_helper.c             | 12 ++++--------
>  target/ppc/translate/vsx-impl.inc.c | 10 +++++-----
>  3 files changed, 11 insertions(+), 15 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
