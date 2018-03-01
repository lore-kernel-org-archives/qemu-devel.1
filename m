Received: from eggs.gnu.org ([2001:4830:134:3::10]:41034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erMjL-0006Yv-4i
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:50:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erMjK-0006zJ-FG
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:50:35 -0500
Received: from mail-ot0-x22a.google.com ([2607:f8b0:4003:c0f::22a]:35298)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1erMjK-0006yz-A0
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:50:34 -0500
Received: by mail-ot0-x22a.google.com with SMTP id w2so5296132otg.2
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 03:50:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180228164816.24110-1-richard.henderson@linaro.org>
References: <20180228164816.24110-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Mar 2018 11:50:13 +0000
Message-ID: <CAFEAcA_--27=va-PEtWporwmF23TueP-j=g0MMbF9ZW4L4K29A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [RISU 0/3] ARM additions for v8.1-simd
 and v8.3-compnum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 28 February 2018 at 16:48, Richard Henderson
<richard.henderson@linaro.org> wrote:
> I've rebased these onto master.  There don't seem to be any
> consistent examples of how extensions are to be named in this
> new group-enabled world, but it's my opinion that the bike
> shed should be green.
>
> Since fp16 support is not yet present on the AArch32 side,
> I have disabled generation of those instructions here.

Applied to risu master, thanks.

-- PMM
