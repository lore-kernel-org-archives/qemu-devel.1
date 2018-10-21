Received: from eggs.gnu.org ([2001:4830:134:3::10]:39452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDPX-0004B7-Jj
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:04:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDPU-0006vM-E3
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:04:51 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:36082)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEDPT-0006uU-Vl
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:04:48 -0400
Received: by mail-wm1-x32a.google.com with SMTP id a8-v6so7662272wmf.1
	for <qemu-devel@nongnu.org>; Sun, 21 Oct 2018 06:04:47 -0700 (PDT)
References: <20181019010625.25294-1-cota@braap.org>
	<20181019010625.25294-19-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2895915e-9a23-5b59-10b9-4b6d5ad6ef67@linaro.org>
Date: Sun, 21 Oct 2018 14:04:42 +0100
MIME-Version: 1.0
In-Reply-To: <20181019010625.25294-19-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 18/56] sparc: convert to cpu_halted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Fabien Chouteau <chouteau@adacore.com>

On 10/19/18 2:05 AM, Emilio G. Cota wrote:
> Cc: Fabien Chouteau <chouteau@adacore.com>
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Cc: Artyom Tarasenko <atar4qemu@gmail.com>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  hw/sparc/leon3.c      | 2 +-
>  hw/sparc/sun4m.c      | 8 ++++----
>  hw/sparc64/sparc64.c  | 4 ++--
>  target/sparc/helper.c | 2 +-
>  4 files changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
