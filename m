Received: from eggs.gnu.org ([2001:4830:134:3::10]:56515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dQc6j-0000OG-Nm
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:15:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dQc6j-0002Iy-0i
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:15:53 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:35165)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dQc6i-0002IC-QX
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:15:52 -0400
Received: by mail-wr0-x22f.google.com with SMTP id k67so191483098wrc.2
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 09:15:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <024979b1-9a1a-0556-5138-480f8ed1a70e@redhat.com>
References: <1497369290-20401-1-git-send-email-peter.maydell@linaro.org>
	<1497369290-20401-3-git-send-email-peter.maydell@linaro.org>
	<024979b1-9a1a-0556-5138-480f8ed1a70e@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Jun 2017 17:15:31 +0100
Message-ID: <CAFEAcA9Ct0X95n3fKE+Dd=it93OSuOJuqjXWi_zmOYD+a7265g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/3] scripts/run-coverity-scan: Script to
 run Coverity Scan build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On 29 June 2017 at 17:12, Eric Blake <eblake@redhat.com> wrote:
> Thankfully, I didn't see any bashisms, so you appeared to have stuck to
> portable /bin/sh code.

My /bin/sh is dash, which catches at least some of the more
obvious bashisms.

thanks
-- PMM
