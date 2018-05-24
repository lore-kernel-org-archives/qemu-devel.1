Received: from eggs.gnu.org ([2001:4830:134:3::10]:44875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fLvak-0001GB-Tr
	for qemu-devel@nongnu.org; Thu, 24 May 2018 15:08:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fLvag-0000YJ-Q5
	for qemu-devel@nongnu.org; Thu, 24 May 2018 15:08:02 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:36521)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fLvag-0000Xz-HC
	for qemu-devel@nongnu.org; Thu, 24 May 2018 15:07:58 -0400
Received: by mail-pg0-x243.google.com with SMTP id u7-v6so1199667pgp.3
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 12:07:58 -0700 (PDT)
References: <20180522175629.24932-1-richard.henderson@linaro.org>
	<CAFEAcA_-tuEXm0gGNkzs0xb2Rm90Nm_t2i3pYJRULay08h_FLg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5b2649f6-a26b-17e9-ed26-bb1e66f8a7b8@linaro.org>
Date: Thu, 24 May 2018 12:07:54 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_-tuEXm0gGNkzs0xb2Rm90Nm_t2i3pYJRULay08h_FLg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tcg: Fix helper function vs host abi for
 float16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 05/24/2018 06:21 AM, Peter Maydell wrote:
> Applied to target-arm.next, thanks. Is it worth marking this as
> cc:stable?

Probably, since we've marked most of the other f16 patches for stable.


r~
