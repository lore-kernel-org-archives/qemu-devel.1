Received: from eggs.gnu.org ([2001:4830:134:3::10]:39452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDPt-0004B7-Er
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:05:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDME-000593-6o
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:01:30 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:40658)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEDME-00058L-0G
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:01:26 -0400
Received: by mail-wr1-x42a.google.com with SMTP id d2-v6so41997490wro.7
	for <qemu-devel@nongnu.org>; Sun, 21 Oct 2018 06:01:25 -0700 (PDT)
References: <20181019010625.25294-1-cota@braap.org>
	<20181019010625.25294-15-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1a456428-cf9d-9f99-f675-a981fa619e9f@linaro.org>
Date: Sun, 21 Oct 2018 14:01:21 +0100
MIME-Version: 1.0
In-Reply-To: <20181019010625.25294-15-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 14/56] m68k: convert to cpu_halted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>

On 10/19/18 2:05 AM, Emilio G. Cota wrote:
> Cc: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/m68k/op_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
