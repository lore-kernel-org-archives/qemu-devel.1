Received: from eggs.gnu.org ([2001:4830:134:3::10]:40745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f5kPB-0004g2-DB
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 23:57:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f5kPA-000113-Mk
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 23:57:13 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:38657)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f5kPA-00010q-HJ
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 23:57:12 -0400
Received: by mail-pf0-x241.google.com with SMTP id y69so7143578pfb.5
	for <qemu-devel@nongnu.org>; Mon, 09 Apr 2018 20:57:12 -0700 (PDT)
References: <1523038800-2494-1-git-send-email-cota@braap.org>
	<1523038800-2494-8-git-send-email-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a62e1b9b-7a9b-8a9b-33cf-c8e8d5767b46@linaro.org>
Date: Tue, 10 Apr 2018 13:57:06 +1000
MIME-Version: 1.0
In-Reply-To: <1523038800-2494-8-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 07/17] target/mips: convert to
 DisasContextBase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>

On 04/07/2018 04:19 AM, Emilio G. Cota wrote:
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/mips/translate.c | 346 ++++++++++++++++++++++++------------------------
>  1 file changed, 175 insertions(+), 171 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
