Received: from eggs.gnu.org ([2001:4830:134:3::10]:42074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1elelt-0001mT-CW
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:53:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1elelq-0007ZG-Ax
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:53:37 -0500
Received: from mail-io0-x229.google.com ([2607:f8b0:4001:c06::229]:33104)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1elelq-0007Yi-3h
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:53:34 -0500
Received: by mail-io0-x229.google.com with SMTP id n7so22219030iob.0
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 09:53:33 -0800 (PST)
References: <20180213072150.32252-1-richard.henderson@linaro.org>
	<CAFEAcA_Nj8ToSr2cDZja9qMiTVanhGAwLcj4LNFW4z2MjJpNmw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b0bb245c-2e98-7f86-feea-b331aeb9f95c@linaro.org>
Date: Tue, 13 Feb 2018 09:53:29 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_Nj8ToSr2cDZja9qMiTVanhGAwLcj4LNFW4z2MjJpNmw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] scripts: Add decodetree.py
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

On 02/13/2018 02:05 AM, Peter Maydell wrote:
> Trivial-but-important nit: all these new files are missing
> copyright-and-license comment headers.

Oops, fixed.  I also added a one-line comment describing what each of the tests
are attempting.


r~
