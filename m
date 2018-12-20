Received: from eggs.gnu.org ([2001:4830:134:3::10]:42818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ga2J2-0005Jm-89
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 12:40:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ga2Iy-0001EZ-7T
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 12:40:20 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:36867)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ga2Iv-00016m-W1
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 12:40:14 -0500
Received: by mail-pl1-x641.google.com with SMTP id b5so1203920plr.4
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 09:40:10 -0800 (PST)
References: <20181220163123.9233-1-mark.cave-ayland@ilande.co.uk>
	<20181220163123.9233-2-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <eea9c980-d4f4-7eea-cb24-f25641dc9afc@linaro.org>
Date: Thu, 20 Dec 2018 09:40:05 -0800
MIME-Version: 1.0
In-Reply-To: <20181220163123.9233-2-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/9] target/ppc: fix typo in SIMM5
 extraction helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 12/20/18 8:31 AM, Mark Cave-Ayland wrote:
> As the macro name suggests, the argument should be signed and not unsigned.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/internal.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
