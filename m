Received: from eggs.gnu.org ([2001:4830:134:3::10]:41729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPAdk-0004Tn-81
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:11:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPAdj-0003sT-E1
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:11:44 -0500
Received: from mail-ua0-x235.google.com ([2607:f8b0:400c:c08::235]:32795)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cPAdj-0003sN-9K
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:11:43 -0500
Received: by mail-ua0-x235.google.com with SMTP id i68so277962675uad.0
	for <qemu-devel@nongnu.org>; Thu, 05 Jan 2017 08:11:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <e90abf9b-f474-2adc-1b2d-5d1df7fb1505@freebsd.org>
References: <5dd3d27a-e630-4e92-43fa-13c131e9f880@freebsd.org>
	<e90abf9b-f474-2adc-1b2d-5d1df7fb1505@freebsd.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Jan 2017 16:11:22 +0000
Message-ID: <CAFEAcA9ayxt_fNRd1eRkJVFMa4tEx=nPwAF0L6p23Z1f_XQOYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] New Year's starting over ... bsd-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sean Bruno <sbruno@freebsd.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 5 January 2017 at 16:03, Sean Bruno <sbruno@freebsd.org> wrote:
> Ok, this is probably too big for a single patch.  I'll see if its
> reasonable to break this up across *some* kind of logic boundary.

Yeah, that's pretty huge. My rough rule of thumb: prefer
each patch to be <500 lines, prefer <20 patches in a patchset.

thanks
-- PMM
