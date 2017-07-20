Received: from eggs.gnu.org ([2001:4830:134:3::10]:34380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dYDUF-000542-At
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:35:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dYDUE-0000yy-NL
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:35:35 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:38617)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dYDUE-0000yc-Ga
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:35:34 -0400
Received: by mail-wr0-x22e.google.com with SMTP id f21so15894306wrf.5
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 08:35:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87zibz2w4c.fsf@dusky.pond.sub.org>
References: <1500021225-4118-1-git-send-email-peter.maydell@linaro.org>
	<87zibz2w4c.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Jul 2017 16:35:12 +0100
Message-ID: <CAFEAcA-QEpAuh-CTrC-XvHHAWwhCT85M9Pwn3fAngpXDK8F7Fw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/3] Fix NetBSD build (don't build ivshmem
 tools)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kamil Rytarowski <n54@gmx.com>, "patches@linaro.org" <patches@linaro.org>

On 20 July 2017 at 12:20, Markus Armbruster <armbru@redhat.com> wrote:
> Regardless of my inability to find CONFIG_IVSHMEM confusing (see PATCH
> 1), series
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Thanks; patchset applied to master.

-- PMM
