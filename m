Received: from eggs.gnu.org ([2001:4830:134:3::10]:49660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1enUae-0006kS-H7
	for qemu-devel@nongnu.org; Sun, 18 Feb 2018 14:25:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1enUab-0005yE-EI
	for qemu-devel@nongnu.org; Sun, 18 Feb 2018 14:25:36 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:43098)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1enUab-0005y4-6T
	for qemu-devel@nongnu.org; Sun, 18 Feb 2018 14:25:33 -0500
Received: by mail-pf0-x241.google.com with SMTP id z14so412401pfe.10
	for <qemu-devel@nongnu.org>; Sun, 18 Feb 2018 11:25:33 -0800 (PST)
References: <1518736676-5994-1-git-send-email-cota@braap.org>
	<1518736676-5994-2-git-send-email-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <560dd1e8-d5e3-28c3-d7a4-81eab1d84ce8@linaro.org>
Date: Sun, 18 Feb 2018 11:25:28 -0800
MIME-Version: 1.0
In-Reply-To: <1518736676-5994-2-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] target/sparc: convert to DisasJumpType
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>

On 02/15/2018 03:17 PM, Emilio G. Cota wrote:
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/sparc/translate.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
