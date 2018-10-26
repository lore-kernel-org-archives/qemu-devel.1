Received: from eggs.gnu.org ([2001:4830:134:3::10]:36428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG3Ze-0006K3-HF
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:58:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG3Zb-0005hm-Cx
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:58:54 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:34212)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gG3Zb-0005hb-5a
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:58:51 -0400
Received: by mail-wr1-x430.google.com with SMTP id l6-v6so1696836wrt.1
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 07:58:51 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-10-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1c790eae-a08f-e355-7777-cdc6fce4eab2@linaro.org>
Date: Fri, 26 Oct 2018 15:58:48 +0100
MIME-Version: 1.0
In-Reply-To: <20181025144644.15464-10-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 10/71] hppa: convert to
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
Cc: Paolo Bonzini <pbonzini@redhat.com>

On 10/25/18 3:45 PM, Emilio G. Cota wrote:
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/hppa/translate.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
