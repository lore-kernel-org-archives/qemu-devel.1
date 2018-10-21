Received: from eggs.gnu.org ([2001:4830:134:3::10]:40851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDVT-0001G4-IK
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:11:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDVL-0003bK-A0
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:10:56 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:45978)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEDVJ-0003Yz-9G
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:10:49 -0400
Received: by mail-wr1-x429.google.com with SMTP id f17-v6so10233215wrs.12
	for <qemu-devel@nongnu.org>; Sun, 21 Oct 2018 06:10:46 -0700 (PDT)
References: <20181019010625.25294-1-cota@braap.org>
	<20181019010625.25294-21-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3622cf9c-f74f-67d8-747b-a2e97b246549@linaro.org>
Date: Sun, 21 Oct 2018 14:10:42 +0100
MIME-Version: 1.0
In-Reply-To: <20181019010625.25294-21-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 20/56] gdbstub: convert to cpu_halted
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

On 10/19/18 2:05 AM, Emilio G. Cota wrote:
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  gdbstub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
