Received: from eggs.gnu.org ([2001:4830:134:3::10]:53706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gS5W7-0002zY-Le
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 14:29:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gS5W4-0008Bt-Ho
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 14:28:59 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e]:44273)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gS5W4-0008BN-B8
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 14:28:56 -0500
Received: by mail-pf1-x42e.google.com with SMTP id u6so10648608pfh.11
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 11:28:56 -0800 (PST)
References: <cover.1543352682.git.alistair.francis@wdc.com>
	<d8b4004e95370a8a95bab0506ad5385aa8633cfd.1543352682.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <85d5af73-a15f-aa5e-a3f9-2c18ae87a5d2@linaro.org>
Date: Wed, 28 Nov 2018 11:28:52 -0800
MIME-Version: 1.0
In-Reply-To: <d8b4004e95370a8a95bab0506ad5385aa8633cfd.1543352682.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2 05/24] riscv: Add the tcg-target header
 file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: "alistair23@gmail.com" <alistair23@gmail.com>

On 11/27/18 1:07 PM, Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> ---
>  tcg/riscv/tcg-target.h | 173 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 173 insertions(+)
>  create mode 100644 tcg/riscv/tcg-target.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
