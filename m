Received: from eggs.gnu.org ([2001:4830:134:3::10]:47677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUshG-00013y-DK
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:24:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUsUo-0002IO-J2
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:11:11 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:42748)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gUsUn-0002Hx-51
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:11:10 -0500
Received: by mail-ot1-x341.google.com with SMTP id v23so166000otk.9
	for <qemu-devel@nongnu.org>; Thu, 06 Dec 2018 04:11:09 -0800 (PST)
MIME-Version: 1.0
References: <20181203203839.757-1-richard.henderson@linaro.org>
	<20181203203839.757-4-richard.henderson@linaro.org>
In-Reply-To: <20181203203839.757-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Dec 2018 12:10:57 +0000
Message-ID: <CAFEAcA9VmBtW7ARwbhLzQdK812Qyx=j=AaG+72zNAc=VBDF1SA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 03/10] target/arm: Add SCR_EL3 bits up
 to ARMv8.5
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Mon, 3 Dec 2018 at 20:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Post v8.4 bits taken from SysReg_v85_xml-00bet8.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
