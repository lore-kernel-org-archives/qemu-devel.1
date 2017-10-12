Received: from eggs.gnu.org ([2001:4830:134:3::10]:47985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e2enj-000615-7B
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 10:49:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e2ene-0002rk-DH
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 10:49:31 -0400
Received: from mail-pf0-x22b.google.com ([2607:f8b0:400e:c00::22b]:51525)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e2ene-0002rU-7X
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 10:49:26 -0400
Received: by mail-pf0-x22b.google.com with SMTP id n14so5138683pfh.8
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 07:49:26 -0700 (PDT)
References: <20170928165414.7339-1-richard.henderson@linaro.org>
	<CAFEAcA9aLDDFoTHY+wHGV3S-squwtxs7kaaA6iiCivnOH3ACbA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5543b97c-407e-a77e-8cfd-5c7d971bb815@linaro.org>
Date: Thu, 12 Oct 2017 07:49:22 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9aLDDFoTHY+wHGV3S-squwtxs7kaaA6iiCivnOH3ACbA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 0/9] Support the Capstone disassembler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 10/12/2017 05:34 AM, Peter Maydell wrote:
> I think the "add as submodule" patch might want to be
> revised in the light of the changes to handling of
> submodules that the current UI pull request is making,
> but are the first 8 patches here more or less ready to
> go in?

Yes, the first 8 are ready.

I'll fix up the 9th to follow the UI modules changes, and the new mirror.


r~
