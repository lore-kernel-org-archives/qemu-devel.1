Received: from eggs.gnu.org ([209.51.188.92]:51533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLAqN-0005l8-2u
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 14:17:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLAqM-0008UU-5V
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 14:17:35 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:42118)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLAqL-0008UO-Uy
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 14:17:34 -0400
Received: by mail-oi1-x243.google.com with SMTP id k9so6076002oig.9
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 11:17:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190318134019.23729-1-peter.maydell@linaro.org>
	<41b21196-5401-898d-4afc-6fffa71d09dd@collabora.com>
	<498af98a-5be0-a589-c7b5-246c4d0ee7ef@collabora.com>
In-Reply-To: <498af98a-5be0-a589-c7b5-246c4d0ee7ef@collabora.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 19:17:21 +0100
Message-ID: <CAFEAcA-fzPzZFV_orPL84syTdTqrseHUiwuba9vzrNgz95BHGA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] configure: Remove --source-path option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Antonio Ospite <antonio.ospite@collabora.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>

On Thu, 25 Apr 2019 at 17:42, Antonio Ospite
<antonio.ospite@collabora.com> wrote:
> Now that 4.0 has been released, maybe we can move on with this minor change.
>
> I will send a fix for https://bugs.launchpad.net/qemu/+bug/1817345 after
> this patch lands.

This patch has just gone in to master, so that should be ok
for you to rebase your patch on now.

thanks
-- PMM
