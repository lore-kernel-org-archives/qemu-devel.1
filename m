Received: from eggs.gnu.org ([2001:4830:134:3::10]:52606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkoLa-0002dq-04
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 06:27:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkoLV-0006WA-4V
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 06:27:14 -0400
Received: from mail-ua0-x22a.google.com ([2607:f8b0:400c:c08::22a]:33236)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fkoLU-0006W0-TP
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 06:27:09 -0400
Received: by mail-ua0-x22a.google.com with SMTP id i4-v6so12334870uak.0
	for <qemu-devel@nongnu.org>; Wed, 01 Aug 2018 03:27:08 -0700 (PDT)
References: <CABoDooMm7+REK+8dbTA1zj2mV-OiiA0w2ib8B7b-1WwVny82PA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <920ca79f-932e-d9d6-4b57-8974cd67d4cc@linaro.org>
Date: Wed, 1 Aug 2018 06:27:04 -0400
MIME-Version: 1.0
In-Reply-To: <CABoDooMm7+REK+8dbTA1zj2mV-OiiA0w2ib8B7b-1WwVny82PA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] ARM: SVE movprfx issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Desnogues <laurent.desnogues@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 08/01/2018 05:38 AM, Laurent Desnogues wrote:
> there's a typo in sve_movz_d where n[1] is used instead of n[i].

Oops.  Thanks, fix queued.


r~
