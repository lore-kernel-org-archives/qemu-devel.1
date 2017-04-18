Received: from eggs.gnu.org ([2001:4830:134:3::10]:40900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d0SyW-0005OZ-9m
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 09:15:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d0SyV-0007UT-6y
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 09:15:20 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:37888)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d0SyU-0007UB-Vp
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 09:15:19 -0400
Received: by mail-wm0-x22c.google.com with SMTP id r190so14402504wme.1
	for <qemu-devel@nongnu.org>; Tue, 18 Apr 2017 06:15:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <149193892875.15312.10880186639757781549@loki>
References: <149193892875.15312.10880186639757781549@loki>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Apr 2017 14:14:57 +0100
Message-ID: <CAFEAcA-m67wXgX8W_jEj10T+P3A2NEa_iS3MdQqWhd7DD+W7HA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [ANNOUNCE] QEMU 2.9.0-rc4 is now available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 11 April 2017 at 20:28, Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> Hello,
>
> On behalf of the QEMU Team, I'd like to announce the availability of the
> fifth release candidate for the QEMU 2.9 release.  This release is meant
> for testing purposes and should not be used in a production environment.
>
>   http://download.qemu-project.org/qemu-2.9.0-rc4.tar.xz
>   http://download.qemu-project.org/qemu-2.9.0-rc4.tar.xz.sig
>
> A note from the maintainer:
>
>   This is intended to be the final release candidate for v2.9.0, and
>   unless any showstopper bugs are reported we plan to cut the final
>   release next week on the 18th April.

Regrettably there were a couple of final bugs we needed
to squash, and so the revised plan is to roll an rc5 today
and then have final release on Thursday or Friday.

thanks
-- PMM
